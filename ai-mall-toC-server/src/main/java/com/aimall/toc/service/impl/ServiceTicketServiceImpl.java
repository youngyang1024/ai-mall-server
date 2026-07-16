package com.aimall.toc.service.impl;

import com.aimall.common.constant.ServiceTicketStatus;
import com.aimall.common.constant.ServiceTicketUserType;
import com.aimall.common.entity.ServiceCategory;
import com.aimall.common.entity.ServiceIssue;
import com.aimall.common.entity.ServiceTicket;
import com.aimall.common.entity.ServiceTicketAttachment;
import com.aimall.common.entity.ServiceTicketReply;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceCategoryOptionVO;
import com.aimall.common.vo.ServiceIssueOptionVO;
import com.aimall.common.vo.ServiceTicketAttachmentVO;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.common.vo.ServiceTicketReplyVO;
import com.aimall.toc.dto.ServiceTicketCreateDTO;
import com.aimall.toc.dto.ServiceTicketReplyDTO;
import com.aimall.toc.mapper.ServiceCategoryMapper;
import com.aimall.toc.mapper.ServiceIssueMapper;
import com.aimall.toc.mapper.ServiceTicketAttachmentMapper;
import com.aimall.toc.mapper.ServiceTicketMapper;
import com.aimall.toc.mapper.ServiceTicketReplyMapper;
import com.aimall.toc.service.ServiceTicketService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * C端服务工单实现：工单分类/问题选项查询、工单创建、我的工单列表与详情、用户回复、用户完结
 *
 * <p>1. 创建：校验分类与问题有效性及归属关系、按分类要求校验订单号，生成工单号后落库，并保存首条回复与附件（事务）
 * <p>2. 回复：校验工单归属且未完结，追加回复与附件，同时将工单状态重置为待处理并更新最后回复方（事务）
 * <p>3. 完结：校验工单归属后将状态置为已完成；详情按回复维度聚合附件返回
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class ServiceTicketServiceImpl implements ServiceTicketService {

    private static final DateTimeFormatter TICKET_NO_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    private final ServiceCategoryMapper serviceCategoryMapper;
    private final ServiceIssueMapper serviceIssueMapper;
    private final ServiceTicketMapper serviceTicketMapper;
    private final ServiceTicketReplyMapper serviceTicketReplyMapper;
    private final ServiceTicketAttachmentMapper serviceTicketAttachmentMapper;

    public ServiceTicketServiceImpl(ServiceCategoryMapper serviceCategoryMapper,
                                    ServiceIssueMapper serviceIssueMapper,
                                    ServiceTicketMapper serviceTicketMapper,
                                    ServiceTicketReplyMapper serviceTicketReplyMapper,
                                    ServiceTicketAttachmentMapper serviceTicketAttachmentMapper) {
        this.serviceCategoryMapper = serviceCategoryMapper;
        this.serviceIssueMapper = serviceIssueMapper;
        this.serviceTicketMapper = serviceTicketMapper;
        this.serviceTicketReplyMapper = serviceTicketReplyMapper;
        this.serviceTicketAttachmentMapper = serviceTicketAttachmentMapper;
    }

    @Override
    public List<ServiceCategoryOptionVO> getOptions() {
        List<ServiceCategory> categories = serviceCategoryMapper.selectEnabledList();
        List<ServiceIssue> issues = serviceIssueMapper.selectEnabledList();
        Map<Long, List<ServiceIssue>> issueMap = issues.stream().collect(Collectors.groupingBy(ServiceIssue::getCategoryId));
        List<ServiceCategoryOptionVO> result = new ArrayList<>();
        for (ServiceCategory category : categories) {
            ServiceCategoryOptionVO categoryVO = new ServiceCategoryOptionVO();
            categoryVO.setId(category.getId());
            categoryVO.setCode(category.getCode());
            categoryVO.setName(category.getName());
            categoryVO.setIcon(category.getIcon());
            categoryVO.setNeedOrderNo(category.getNeedOrderNo());
            List<ServiceIssueOptionVO> issueVOList = new ArrayList<>();
            for (ServiceIssue issue : issueMap.getOrDefault(category.getId(), new ArrayList<>())) {
                ServiceIssueOptionVO issueVO = new ServiceIssueOptionVO();
                issueVO.setId(issue.getId());
                issueVO.setCode(issue.getCode());
                issueVO.setName(issue.getName());
                issueVOList.add(issueVO);
            }
            categoryVO.setIssues(issueVOList);
            result.add(categoryVO);
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String create(Long userId, ServiceTicketCreateDTO dto) {
        ServiceCategory category = getCategory(dto.getCategoryId());
        ServiceIssue issue = getIssue(dto.getIssueId());
        validateCategoryIssue(category, issue);
        validateCreateForm(category, dto);

        ServiceTicket ticket = new ServiceTicket();
        ticket.setTicketNo(generateTicketNo());
        ticket.setUserId(userId);
        ticket.setCategoryId(category.getId());
        ticket.setCategoryName(category.getName());
        ticket.setIssueId(issue.getId());
        ticket.setIssueName(issue.getName());
        ticket.setOrderNo(dto.getOrderNo());
        ticket.setContent(dto.getContent());
        ticket.setStatus(ServiceTicketStatus.PENDING.getCode());
        ticket.setContactFirstName(dto.getContactFirstName());
        ticket.setContactLastName(dto.getContactLastName());
        ticket.setContactEmail(dto.getContactEmail());
        ticket.setContactAreaCode(dto.getContactAreaCode());
        ticket.setContactPhone(dto.getContactPhone());
        ticket.setLastReplyUserType(ServiceTicketUserType.USER.getCode());
        serviceTicketMapper.insert(ticket);

        ServiceTicketReply reply = new ServiceTicketReply();
        reply.setTicketId(ticket.getId());
        reply.setUserType(ServiceTicketUserType.USER.getCode());
        reply.setUserId(userId);
        reply.setContent(dto.getContent());
        serviceTicketReplyMapper.insert(reply);

        saveAttachments(ticket.getId(), reply.getId(), ServiceTicketUserType.USER.getCode(), dto.getAttachmentUrls());
        return ticket.getTicketNo();
    }

    @Override
    public PageResult<ServiceTicketListVO> listByUser(Long userId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ServiceTicket> list = serviceTicketMapper.selectByUserId(userId);
        PageInfo<ServiceTicket> pageInfo = new PageInfo<>(list);
        List<ServiceTicketListVO> voList = list.stream().map(this::toListVO).collect(Collectors.toList());
        return PageResult.of(voList, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());
    }

    @Override
    public ServiceTicketDetailVO detail(Long userId, String ticketNo) {
        ServiceTicket ticket = serviceTicketMapper.selectByTicketNoAndUserId(ticketNo, userId);
        if (ticket == null) {
            throw new BusinessException("Ticket not found");
        }
        return buildDetailVO(ticket);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reply(Long userId, String ticketNo, ServiceTicketReplyDTO dto) {
        ServiceTicket ticket = serviceTicketMapper.selectByTicketNoAndUserId(ticketNo, userId);
        if (ticket == null) {
            throw new BusinessException("Ticket not found");
        }
        if (Objects.equals(ticket.getStatus(), ServiceTicketStatus.COMPLETED.getCode())) {
            throw new BusinessException("Ticket has been completed");
        }

        ServiceTicketReply reply = new ServiceTicketReply();
        reply.setTicketId(ticket.getId());
        reply.setUserType(ServiceTicketUserType.USER.getCode());
        reply.setUserId(userId);
        reply.setContent(dto.getContent());
        serviceTicketReplyMapper.insert(reply);

        saveAttachments(ticket.getId(), reply.getId(), ServiceTicketUserType.USER.getCode(), dto.getAttachmentUrls());
        serviceTicketMapper.updateStatusAndLastReply(ticket.getId(),
                ServiceTicketStatus.PENDING.getCode(), ServiceTicketUserType.USER.getCode());
    }

    @Override
    public void complete(Long userId, String ticketNo) {
        ServiceTicket ticket = serviceTicketMapper.selectByTicketNoAndUserId(ticketNo, userId);
        if (ticket == null) {
            throw new BusinessException("Ticket not found");
        }
        serviceTicketMapper.updateStatusByUser(ticket.getId(), userId, ServiceTicketStatus.COMPLETED.getCode());
    }

    private ServiceCategory getCategory(Long categoryId) {
        return serviceCategoryMapper.selectEnabledList().stream()
                .filter(item -> Objects.equals(item.getId(), categoryId))
                .findFirst()
                .orElseThrow(() -> new BusinessException("Category not found"));
    }

    private ServiceIssue getIssue(Long issueId) {
        ServiceIssue issue = serviceIssueMapper.selectById(issueId);
        if (issue == null || !Objects.equals(issue.getStatus(), 1)) {
            throw new BusinessException("Issue not found");
        }
        return issue;
    }

    private void validateCategoryIssue(ServiceCategory category, ServiceIssue issue) {
        if (!Objects.equals(category.getId(), issue.getCategoryId())) {
            throw new BusinessException("Issue does not belong to category");
        }
    }

    private void validateCreateForm(ServiceCategory category, ServiceTicketCreateDTO dto) {
        if (Objects.equals(category.getNeedOrderNo(), 1) && !StringUtils.hasText(dto.getOrderNo())) {
            throw new BusinessException("Order number is required");
        }
    }

    private String generateTicketNo() {
        long suffix = Math.abs(System.nanoTime()) % 10000;
        return "ST" + LocalDateTime.now().format(TICKET_NO_FORMATTER) + String.format("%04d", suffix);
    }

    private void saveAttachments(Long ticketId, Long replyId, Integer userType, List<String> attachmentUrls) {
        if (CollectionUtils.isEmpty(attachmentUrls)) {
            return;
        }
        for (String url : attachmentUrls) {
            if (!StringUtils.hasText(url)) {
                continue;
            }
            ServiceTicketAttachment attachment = new ServiceTicketAttachment();
            attachment.setTicketId(ticketId);
            attachment.setReplyId(replyId);
            attachment.setUserType(userType);
            attachment.setFileName(extractFileName(url));
            attachment.setFileUrl(url);
            attachment.setFileType(extractExtension(url));
            attachment.setFileSize(0L);
            serviceTicketAttachmentMapper.insert(attachment);
        }
    }

    private ServiceTicketDetailVO buildDetailVO(ServiceTicket ticket) {
        ServiceTicketDetailVO detailVO = new ServiceTicketDetailVO();
        detailVO.setId(ticket.getId());
        detailVO.setTicketNo(ticket.getTicketNo());
        detailVO.setUserId(ticket.getUserId());
        detailVO.setCategoryId(ticket.getCategoryId());
        detailVO.setCategoryName(ticket.getCategoryName());
        detailVO.setIssueId(ticket.getIssueId());
        detailVO.setIssueName(ticket.getIssueName());
        detailVO.setOrderNo(ticket.getOrderNo());
        detailVO.setContent(ticket.getContent());
        detailVO.setStatus(ticket.getStatus());
        detailVO.setStatusDesc(ServiceTicketStatus.getDescByCode(ticket.getStatus()));
        detailVO.setContactFirstName(ticket.getContactFirstName());
        detailVO.setContactLastName(ticket.getContactLastName());
        detailVO.setContactEmail(ticket.getContactEmail());
        detailVO.setContactAreaCode(ticket.getContactAreaCode());
        detailVO.setContactPhone(ticket.getContactPhone());
        detailVO.setCreateTime(ticket.getCreateTime());
        detailVO.setUpdateTime(ticket.getUpdateTime());

        List<ServiceTicketReply> replies = serviceTicketReplyMapper.selectByTicketId(ticket.getId());
        List<ServiceTicketAttachment> attachments = serviceTicketAttachmentMapper.selectByTicketId(ticket.getId());
        Map<Long, List<ServiceTicketAttachmentVO>> attachmentMap = new HashMap<>();
        for (ServiceTicketAttachment attachment : attachments) {
            ServiceTicketAttachmentVO attachmentVO = new ServiceTicketAttachmentVO();
            attachmentVO.setId(attachment.getId());
            attachmentVO.setFileName(attachment.getFileName());
            attachmentVO.setFileUrl(attachment.getFileUrl());
            attachmentVO.setFileType(attachment.getFileType());
            attachmentVO.setFileSize(attachment.getFileSize());
            attachmentVO.setCreateTime(attachment.getCreateTime());
            attachmentMap.computeIfAbsent(attachment.getReplyId(), key -> new ArrayList<>()).add(attachmentVO);
        }

        List<ServiceTicketReplyVO> replyVOList = new ArrayList<>();
        for (ServiceTicketReply reply : replies) {
            ServiceTicketReplyVO replyVO = new ServiceTicketReplyVO();
            replyVO.setId(reply.getId());
            replyVO.setUserType(reply.getUserType());
            replyVO.setUserTypeDesc(reply.getUserType() == ServiceTicketUserType.ADMIN.getCode() ? "客服" : "我");
            replyVO.setUserId(reply.getUserId());
            replyVO.setContent(reply.getContent());
            replyVO.setCreateTime(reply.getCreateTime());
            replyVO.setAttachments(attachmentMap.getOrDefault(reply.getId(), new ArrayList<>()));
            replyVOList.add(replyVO);
        }
        detailVO.setReplies(replyVOList);
        return detailVO;
    }

    private ServiceTicketListVO toListVO(ServiceTicket ticket) {
        ServiceTicketListVO vo = new ServiceTicketListVO();
        vo.setId(ticket.getId());
        vo.setTicketNo(ticket.getTicketNo());
        vo.setUserId(ticket.getUserId());
        vo.setCategoryName(ticket.getCategoryName());
        vo.setIssueName(ticket.getIssueName());
        vo.setOrderNo(ticket.getOrderNo());
        vo.setStatus(ticket.getStatus());
        vo.setStatusDesc(ServiceTicketStatus.getDescByCode(ticket.getStatus()));
        vo.setContactEmail(ticket.getContactEmail());
        vo.setContactPhone(ticket.getContactPhone());
        vo.setCreateTime(ticket.getCreateTime());
        vo.setUpdateTime(ticket.getUpdateTime());
        return vo;
    }

    private String extractFileName(String url) {
        int idx = url.lastIndexOf('/');
        return idx >= 0 ? url.substring(idx + 1) : url;
    }

    private String extractExtension(String url) {
        int idx = url.lastIndexOf('.');
        return idx >= 0 ? url.substring(idx + 1).toLowerCase() : "";
    }
}
