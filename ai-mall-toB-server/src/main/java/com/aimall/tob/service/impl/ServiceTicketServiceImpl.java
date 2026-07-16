package com.aimall.tob.service.impl;

import com.aimall.common.constant.ServiceTicketStatus;
import com.aimall.common.constant.ServiceTicketUserType;
import com.aimall.common.entity.ServiceTicket;
import com.aimall.common.entity.ServiceTicketAttachment;
import com.aimall.common.entity.ServiceTicketReply;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceTicketAttachmentVO;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.common.vo.ServiceTicketReplyVO;
import com.aimall.tob.dto.ServiceTicketAdminReplyDTO;
import com.aimall.tob.mapper.ServiceTicketAttachmentMapper;
import com.aimall.tob.mapper.ServiceTicketMapper;
import com.aimall.tob.mapper.ServiceTicketReplyMapper;
import com.aimall.tob.service.ServiceTicketService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * B端服务工单管理服务实现
 * <p>1. 列表/详情：基于 PageHelper 按状态/工单号/订单号分页查询，详情聚合回复列表并按 replyId 分组挂载附件
 * <p>2. 客服回复：已完成的工单禁止回复；事务内插入 ADMIN 类型回复记录、保存附件（从 URL 提取文件名与扩展名），并将工单状态置为处理中、更新最后回复方
 * <p>3. 状态变更：仅允许待处理/处理中/已完成三个合法状态值，且校验工单存在
 * <p>4. 依赖 ServiceTicketMapper、ServiceTicketReplyMapper、ServiceTicketAttachmentMapper
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class ServiceTicketServiceImpl implements ServiceTicketService {

    private final ServiceTicketMapper serviceTicketMapper;
    private final ServiceTicketReplyMapper serviceTicketReplyMapper;
    private final ServiceTicketAttachmentMapper serviceTicketAttachmentMapper;

    public ServiceTicketServiceImpl(ServiceTicketMapper serviceTicketMapper,
                                    ServiceTicketReplyMapper serviceTicketReplyMapper,
                                    ServiceTicketAttachmentMapper serviceTicketAttachmentMapper) {
        this.serviceTicketMapper = serviceTicketMapper;
        this.serviceTicketReplyMapper = serviceTicketReplyMapper;
        this.serviceTicketAttachmentMapper = serviceTicketAttachmentMapper;
    }

    @Override
    public PageResult<ServiceTicketListVO> list(Integer status, String ticketNo, String orderNo, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ServiceTicket> list = serviceTicketMapper.selectList(status, ticketNo, orderNo);
        PageInfo<ServiceTicket> pageInfo = new PageInfo<>(list);
        List<ServiceTicketListVO> voList = list.stream().map(this::toListVO).collect(Collectors.toList());
        return PageResult.of(voList, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());
    }

    @Override
    public ServiceTicketDetailVO detail(Long id) {
        ServiceTicket ticket = getTicket(id);
        return buildDetailVO(ticket);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reply(Long id, ServiceTicketAdminReplyDTO dto) {
        ServiceTicket ticket = getTicket(id);
        if (Objects.equals(ticket.getStatus(), ServiceTicketStatus.COMPLETED.getCode())) {
            throw new BusinessException("工单已完成，无法继续回复");
        }
        ServiceTicketReply reply = new ServiceTicketReply();
        reply.setTicketId(ticket.getId());
        reply.setUserType(ServiceTicketUserType.ADMIN.getCode());
        reply.setUserId(0L);
        reply.setContent(dto.getContent());
        serviceTicketReplyMapper.insert(reply);
        saveAttachments(ticket.getId(), reply.getId(), dto.getAttachmentUrls());
        serviceTicketMapper.updateStatusAndLastReply(ticket.getId(),
                ServiceTicketStatus.PROCESSING.getCode(), ServiceTicketUserType.ADMIN.getCode());
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        if (!Objects.equals(status, ServiceTicketStatus.PENDING.getCode())
                && !Objects.equals(status, ServiceTicketStatus.PROCESSING.getCode())
                && !Objects.equals(status, ServiceTicketStatus.COMPLETED.getCode())) {
            throw new BusinessException("工单状态不合法");
        }
        getTicket(id);
        serviceTicketMapper.updateStatus(id, status);
    }

    private ServiceTicket getTicket(Long id) {
        ServiceTicket ticket = serviceTicketMapper.selectById(id);
        if (ticket == null) {
            throw new BusinessException("工单不存在");
        }
        return ticket;
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
            replyVO.setUserTypeDesc(reply.getUserType() == ServiceTicketUserType.ADMIN.getCode() ? "客服" : "用户");
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

    private void saveAttachments(Long ticketId, Long replyId, List<String> attachmentUrls) {
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
            attachment.setUserType(ServiceTicketUserType.ADMIN.getCode());
            attachment.setFileName(extractFileName(url));
            attachment.setFileUrl(url);
            attachment.setFileType(extractExtension(url));
            attachment.setFileSize(0L);
            serviceTicketAttachmentMapper.insert(attachment);
        }
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
