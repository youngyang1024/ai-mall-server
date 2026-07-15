-- Homary Flash Sale 商品初始化数据
-- 来源: https://www.homary.com/activity-list/seckilling-goods?type=1
-- 标题已翻译为中文；分类匹配库内二级分类；图片 URL 直接复用 Homary CDN
USE ai_mall;

SET FOREIGN_KEY_CHECKS = 0;

-- 清理本批 Flash Sale 导入区间（id >= 2001），不影响既有 seed 数据
DELETE FROM t_spu_image WHERE spu_id >= 2001;
DELETE FROM t_spu_spec WHERE spu_id >= 2001;
DELETE FROM t_sku WHERE spu_id >= 2001;
DELETE FROM t_spu WHERE id >= 2001;

INSERT INTO t_spu (id, name, category_id, description, main_image, status, sales_count) VALUES
(2001, '日式胡桃木卧室家具款', 14, '<h3>日式胡桃木卧室家具款</h3>
<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Embodying the essence of 日式, this 地板床 is ideal those who appreciate simplicity 与 practicality. Its low-profile, minimalist desi…</p>
<ul>
<li>闪购精选 Low-profile design a sleek, minimalist look that saves space 与 adds a serene vibe to your room</li>
<li>闪购精选 Made 带 premium rubberwood veneer, eco-friendly 与 durable long-lasting quality</li>
<li>闪购精选 Carbon steel slats provide excellent weight support 与 resist corrosion 与 rust over time</li>
<li>闪购精选 No headboard design an open, clutter-free aesthetic that complements any room layout</li>
<li>Embraces a minimalist 日式, ideal creating a peaceful, 现代 卧室 atmosphere</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_68018454ad18e690bce4b73791d09d1b.jpg', 1, 4),
(2002, '模块柚木沙发款', 12, '<h3>模块柚木沙发款</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This modular 火坑桌 沙发 套装 combines 现代 design 带 户外 comfort 与 versatility. It features a customizable 模块沙发 带 plush cushions, a match…</p>
<ul>
<li>闪购精选 【Safety】CSA cetificated 火坑桌, 50,000 BTU max output, equivalent to the heat of 6 fireplaces</li>
<li>【Health】Smokeless propane-fueled 火坑桌 桌子 makes your patio warm 与 healthy</li>
<li>【Frame】灯er but higher strength 与 hardness 铝制 alloy, anti-rust 与 provides more stability</li>
<li>【Material】柚木 wood surface, 带 原木色 oils 与 rubber, protecting the wood from weathering 与 ageing</li>
<li>闪购精选 【Cushion】Waterproof polyester upholstery, high elasticity foam padding, stains&amp;spills resistant 与 comfor桌子</li>
<li>闪购精选 【Design】Modular design allows versatile configurations to suit any patio or garden layout, such as L型, I-shaped as you lik…</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/30/2500x2500_563885afd3a8fad87e374fb6d2743819.jpg', 1, 1000),
(2003, '70.9" 现代 Style 岩板 厨房岛台s 带 Multi-储物 白色', 53, '<h3>70.9" 现代 Style 岩板 厨房岛台s 带 Multi-储物 白色</h3>
<p>Homary Flash Sale 精选【厨房岛台】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This 现代 厨房岛台 features a sleek 白色 岩板 top, perfect any 当代 厨房. 带 3 抽屉, 3 doors, 与 5 shelves, it keeps all your essentials organize…</p>
<ul>
<li>闪购精选 Spacious Workspace – Large countertop provides room meal prep, casual dining, or entertaining</li>
<li>Premium Surface – 岩板 resists scratches, heat, 与 stains keeping your 岛台 loo国王尺寸 new</li>
<li>Ample 储物 – 抽屉, doors, 与 shelves organize cookware, utensils, 与 pantry items</li>
<li>Multifunctional Design – Serves as prep area, 餐桌, or workstation flexible 厨房 use</li>
<li>现代 Style – Sleek 白色 design elevates 厨房 aesthetics while fitting any 当代 space</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 1, 1),
(2004, '83"岩板胡桃木电视柜款', 18, '<h3>83"岩板胡桃木电视柜款</h3>
<p>Homary Flash Sale 精选【电视柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Designed 现代 与 timeless interiors, the Aura 电视柜 brings mid-century warmth to your 客厅 带 ash wood fluted details 与 a travertine st…</p>
<ul>
<li>闪购精选 The fluted design 带 ash wood slats adds depth 与 mid-century character to your space</li>
<li>The 岩板 top is scratch-resistant 与 easy to clean, staying 典雅 over time</li>
<li>闪购精选 Four-level ambient 灯ing creates a warm atmosphere relaxed evenings at home</li>
<li>Spacious 柜子s provide generous 储物 while keeping your living area visually balanced</li>
<li>闪购精选 Cable management keeps wires neatly hidden a clean, uncluttered 套装up</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_776c68b2df6c5982e6f8940dc554d301.jpg', 1, 96),
(2005, '71"双人花洒款', 33, '<h3>71"双人花洒款</h3>
<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Indulge your own 人al luxury 带 this 71" double massage acrylic corner 浴缸, featuring space two bathers. Enhance your bathing 带 38…</p>
<ul>
<li>闪购精选 38 massage jets deliver targeted water pressure muscle relief</li>
<li>闪购精选 Temperature control helps maintain water temperature at its optimal level at all times</li>
<li>闪购精选 瀑布式 back massage adds soothing water flow along the spine</li>
<li>闪购精选 Air bubble system creates gentle micro-bubbles to stimulate skin</li>
<li>闪购精选 120° ergonomic reclined backrest 与 headrest relieve neck 与 back pressure</li>
<li>闪购精选 LED chromotherapy 灯s offer 7 colors mood adjustment</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/10/ca2b2248d9f08dac420975b5b2761632.jpg', 1, 33),
(2006, '3-件 棉麻 L型 组合沙发 带 Side Open 储物', 12, '<h3>3-件 棉麻 L型 组合沙发 带 Side Open 储物</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Embrace 现代 living 带 this spacious 组合沙发, designed flexibility 与 comfort. Its cotton-linen upholstery ensures airflow 与 softness,…</p>
<ul>
<li>Breathable cotton-linen fabric keeps the 沙发 cool 与 comfor桌子 during long use</li>
<li>闪购精选 Modular design allows you to rearrange 件套 a custom fit any room layout</li>
<li>Two 储物 side 桌子s provide space to organize items like books 与 snacks neatly</li>
<li>闪购精选 Extra-wide seating comfortably accommodates up to nine people social events</li>
<li>闪购精选 Durable engineered wood frame ensures stability 与 long-term reliability</li>
<li>闪购精选 Includes six plush pillows extra support 与 a welcoming look your space</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/ad7d891b853f1eda6eedb43a14a1bc63.jpg', 1, 58),
(2007, '铝制休闲椅款', 16, '<h3>铝制休闲椅款</h3>
<p>Homary Flash Sale 精选【休闲椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Elevate your 户外 relaxation 带 this sleek 与 现代 chaise lounge. Designed 带 both style 与 comfort mind, it features a minimalist 黑色 m…</p>
<ul>
<li>FSC-certified 柚木 与 premium 铝制 create a strong, weather-ready frame built long-term 户外 use</li>
<li>闪购精选 Adjus桌子 backrest easily adjust the recline angle reading, napping, or sunbathing to maximize relaxation</li>
<li>闪购精选 Fade, mildew, 与 water-resistant canvas cushions 带 removable covers easy cleaning 与 long-term use</li>
<li>闪购精选 Extra-thick 7.5" cushion offers enhanced comfort sitting or reclining 户外s</li>
<li>Built- 柚木 side 桌子, offers a s桌子 surface drinks 与 books, eliminating the need an extra 户外 桌子</li>
<li>Quick 1-人 partial assembly, includes all hardware easy 套装up 带out professional help</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_d381d45f3b2b3f52b2913af302cef9d0.jpg', 1, 1000),
(2008, 'Hynova AX2 Pro 智能马桶 带 Aromatherapy, 白色, 1.28 GPF', 33, '<h3>Hynova AX2 Pro 智能马桶 带 Aromatherapy, 白色, 1.28 GPF</h3>
<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Elevate your 浴室 带 our Automatic 智能马桶 featuring vibrant color ambient 灯ing 与 aromatherapy. Enjoy auto open lid, 加热 seat, 与 adjus…</p>
<ul>
<li>闪购精选 Auto Open Lid: Lid opens automatically as the user approaches, reducing contact 带 surfaces h与s-free convenience</li>
<li>加热 Seat: Adjus桌子 temperature 套装tings provide 人alized warmth year-round comfort</li>
<li>Adjus桌子 Nozzle Wash: Water angle 与 pressure adjust to 人al preference a tailored cleansing experience</li>
<li>Warm Air Dryer: Three temperature 套装tings allow users to select comfor桌子 drying after washing</li>
<li>闪购精选 Aromatherapy Function: Dispenses scent from essential oils to create a customized 浴室 atmosphere</li>
<li>Vibrant Color Ambient 灯ing: Dynamic colored 灯s offer customizable visual ambiance the 浴室</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_8bd9e87f49e2482713fc3ab7f482bcc3.jpg', 1, 1),
(2009, '83"弧形丝绒沙发款', 12, '<h3>83"弧形丝绒沙发款</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Defined by a sculptural curved silhouette 与 plush 丝绒 upholstery, this 现代 沙发 creates an inviting lounge spot conversation or qui…</p>
<ul>
<li>Plush 丝绒 upholstery 带 high-density foam cushions provides soft comfort, lasting support 与 maintain their shape over time</li>
<li>闪购精选 Solid wood frame provides strong foundation 与 ensures years of reliable use</li>
<li>不锈钢 legs add 现代 elegance 与 s桌子 support to the 沙发 design</li>
<li>闪购精选 Easy assembly just requires attaching the legs so you can start using it quickly</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/06/03/7aef181a1ba049c2bffe4341ab23b8be.jpg', 1, 71),
(2010, '126"L型模块皮质沙发款', 12, '<h3>126"L型模块皮质沙发款</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This 当代 126" L型 组合沙发, featuring modular components 带 a matching ottoman Its modular design gives great flexibility to arrange t…</p>
<ul>
<li>闪购精选 Modular sectional layout adapts to room shapes flexible family seating</li>
<li>闪购精选 Reversible chaise design switches sides to fit different 客厅 layouts</li>
<li>Built- console 带 hidden 储物 keeps remotes 与 snacks 带in easy reach</li>
<li>闪购精选 High-density foam cushions provide comfor桌子 support extended lounging</li>
<li>科技皮 resists stains, water 与 与 daily wear, keeping the 沙发 easy to clean 与 lasting daily use</li>
<li>Solid wood legs offer sturdy support 与 a touch of 原木色 style to the 沙发</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/9fbc03b404081fe1d1051daa11c0b1ef.jpg', 1, 242),
(2011, 'Fitro H1 Compact 智能马桶 带 Deodorization 与 Automatic Flushing, 1.32 GPF', 33, '<h3>Fitro H1 Compact 智能马桶 带 Deodorization 与 Automatic Flushing, 1.32 GPF</h3>
<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This floor-mounted 智能马桶 combines space-saving compact design 带 full-size functionality. Featuring automatic flush, 加热 seat, 与 a…</p>
<ul>
<li>闪购精选 Built- deodorizer removes odors to keep 浴室 air fresh</li>
<li>One-件 compact design saves space while adding a 现代 look to any 浴室</li>
<li>闪购精选 Automatic flush activates when user leaves seat h与s-free hygiene</li>
<li>加热 seat 带 adjus桌子 temperature provides comfort during cold mornings</li>
<li>闪购精选 Customizable warm wash adjusts water temperature, pressure, 与 nozzle position</li>
<li>闪购精选 Warm air dryer eliminates toilet paper a comfor桌子, thorough dry</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 1, 1),
(2012, '铝制休闲椅款', 16, '<h3>铝制休闲椅款</h3>
<p>Homary Flash Sale 精选【休闲椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Transform your 户外 living space 带 this stylish 与 functional swivel lounge 椅子. Designed 带 a sturdy, rust-resistant 铝制 frame 与 uph…</p>
<ul>
<li>FSC-certified 柚木 与 premium 铝制 create a strong, weather-ready frame built lasting 户外 use</li>
<li>闪购精选 360° swivel design lets you turn easily to chat, reach, or enjoy different views more comfortably</li>
<li>6" thick cushion adds supportive comfort, ma国王尺寸 long 户外 lounging feel more relaxed 与 enjoyable</li>
<li>闪购精选 Fade, mildew, 与 water-resistant canvas cushions 带 removable covers easy cleaning 与 long-term use</li>
<li>闪购精选 Removable cushion covers make routine cleaning easier, helping you spend less time on upkeep</li>
<li>Quick 1-人 partial assembly, includes all hardware easy 套装up 带out professional help</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/1600x1600_d441d16a02baa02b59a4c2a9fa071edc.jpg', 1, 1000),
(2013, 'Costra 4-件 户外 绳编 Swivel 沙发 套装 带 茶几 黑色 6', 12, '<h3>Costra 4-件 户外 绳编 Swivel 沙发 套装 带 茶几 黑色 6</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Bring effortless Coastal style to your patio 带 a durable 铝制 frame, weather-resistant 绳编, 与 performance 户外 fabric. This 4-件 户外沙发…</p>
<ul>
<li>铝制 alloy frame resists rust 与 weather long-term 户外 durability</li>
<li>H与woven 绳编 finish 带st与s fading, moisture, 与 mildew while adding texture</li>
<li>闪购精选 High performance canvas cushions are UV- 与 water-resistant 带 removable covers easy care</li>
<li>360° swivel lounge 椅子 allows smooth movement relaxed 户外 conversations</li>
<li>闪购精选 Extra-thick 7.5" cushions 与 28.7" deep seats offer plush, extended comfort</li>
<li>Complete 4-件 套装 includes 3-seater 沙发, 2-seater 沙发, 1 旋转椅, 与 1 茶几</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F4dbcf8ad6a4949639f30536645394236_.jpg', 1, 54),
(2014, '中古风 72" Glossy 岩板 Top 厨房岛台 带储物, 原木色', 53, '<h3>中古风 72" Glossy 岩板 Top 厨房岛台 带储物, 原木色</h3>
<p>Homary Flash Sale 精选【厨房岛台】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Made open 厨房s, daily coo国王尺寸, 与 family gatherings, the 厨房岛台 adds prep space, seating room, 与 organized 储物 to keep routines smoo…</p>
<ul>
<li>闪购精选 岩板 top resists heat, stains, 与 scratches easier daily prep</li>
<li>抽屉, compartments, 与 trash 储物 keep cookware 与 bins organized</li>
<li>闪购精选 Wide countertop supports food prep, casual meals, 与 serving during gatherings</li>
<li>闪购精选 Rubberwood frame 带 ash veneer front adds steady support 与 lasting structure</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 1, 360),
(2015, '84"弧形丝绒沙发款', 12, '<h3>84"弧形丝绒沙发款</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Elevate your space immediately 带 this 3-seater 沙发 boasting a graceful curved silhouette 与 premium 丝绒 fabric. Arrives fully asse…</p>
<ul>
<li>闪购精选 Premium 丝绒 upholstery feels incredibly soft 与 adds a refined touch</li>
<li>闪购精选 Solid wood frame ensures lasting durability 与 reliable support everyday use</li>
<li>闪购精选 High-density foam cushions provide comfor桌子 seating that maintains its shape over time</li>
<li>闪购精选 Curved backrest creates an 典雅 silhouette that enhances aesthetic appeal</li>
<li>闪购精选 Requires no assembly - simply unbox 与 start enjoying your 沙发 immediately</li>
<li>闪购精选 Includes complementary pillows added comfort 与 complete styling</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/1f3bc4195f48b9305df8370fdbc87550.jpg', 1, 54),
(2016, '60"胡桃木书桌款', 17, '<h3>60"胡桃木书桌款</h3>
<p>Homary Flash Sale 精选【书桌】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This versatile 书桌 combines 现代 elegance 带 practical features. The lift-top design creates an ergonomic workspace sitting or st与i…</p>
<ul>
<li>闪购精选 Lift-top design lets you switch sitting or st与ing all-day comfort at home office</li>
<li>闪购精选 Ash wood frame adds stability daily remote work, studying, 与 灯 gaming</li>
<li>Compact structure 带 built- 储物 fits small apartments, dorms, 与 home offices</li>
<li>闪购精选 Hidden 柜子s keep your workspace clutter-free during work, study, or creative tasks</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_562a03bcaece63c7d0ce6cc5d6dea758.jpg', 1, 334),
(2017, '日式简约 72" 白色 厨房岛台 带储物 & LED 灯ing', 44, '<h3>日式简约 72" 白色 厨房岛台 带储物 & LED 灯ing</h3>
<p>Homary Flash Sale 精选【台灯落地灯】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>日式简约 厨房岛台 带储物 designed 厨房 与 餐厅 spaces. Available multiple sizes 与 colors, it offers scratch-resistant surface, practical 储物, 与 …</p>
<ul>
<li>闪购精选 Scratch-resistant 与 easy-to-clean 桌子top everyday use</li>
<li>厨房岛台 带储物 to keep essentials organized</li>
<li>闪购精选 Durable engineered wood construction long-term stability</li>
<li>闪购精选 Multiple size options to fit different space needs</li>
<li>Ideal 餐厅 储物, meal prep, 与 family gatherings</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 1, 211),
(2018, '9-件套 仿大理石 户外 Dining 套装 带 Woven Rope 椅子s 8 人 (86.6")', 13, '<h3>9-件套 仿大理石 户外 Dining 套装 带 Woven Rope 椅子s 8 人 (86.6")</h3>
<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This 典雅 garden 桌子 套装, featuring a sophisticated stone-effect 桌子top 与 a robust 铝制 frame, combines timeless aesthetics 带 durabili…</p>
<ul>
<li>【Easy-care 桌子top】: 典雅 stone look, heat- 与 scratch-resistant, easy to remove oil 与 red wine stains</li>
<li>【Premium 铝制 frame】: 灯er than steel, just as robust, weatherproof, 与 easy to move – ideal 户外 dining</li>
<li>闪购精选 【Like new years】: H与-woven rope 带 a breathable feel that is waterproof, quick-drying, 与 fade-resistant</li>
<li>【Comfor桌子 seat】: Softly padded seat 与 back cushions, as well as ergonomic backrest 与 armrests, ensure comfort even during exten…</li>
<li>闪购精选 【Easy-care cover】: Waterproof, scratch-resistant, fade-resistant, 与 stain-resistant, as well as removable 与 washable</li>
<li>【Contents】: 餐桌 ×1, 餐椅s ×8, including cushions 与 pads</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba661f0bcb8f8633e675b2e19034dca5.jpg', 1, 169),
(2019, '皮质浴室柜款', 31, '<h3>皮质浴室柜款</h3>
<p>Homary Flash Sale 精选【浴室柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Humply makeup 浴室柜 套装 performance 仿皮 is designed style-conscious users, pairing a 灯ed 镜子, multiple-抽屉 储物, 与 a matching stool to …</p>
<ul>
<li>闪购精选 Performance 仿皮 is water-resistant, stain-resistant, 与 scratch-resistant easy care</li>
<li>3-color 灯ed 镜子 带 cool, warm, 与 day灯 modes supports clearer, more precise makeup</li>
<li>Five spacious 抽屉 keep beauty tools 与 daily essentials neatly organized 与 close</li>
<li>Foam-filled stool 带 metal base brings comfor桌子 seating 与 a polished look</li>
<li>Rounded sculptural design gives the 浴室柜 a softer silhouette 与 st与out 现代 appeal</li>
<li>闪购精选 FSC Certified – Made 带 responsibly sourced FSC-certified wood conscious, sustainable quality</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a891337a4dd015aa12e8f002336146e0.jpg', 1, 108),
(2020, 'Fero 71"-110" 可伸缩 电视柜 带 3 抽屉', 18, '<h3>Fero 71"-110" 可伸缩 电视柜 带 3 抽屉</h3>
<p>Homary Flash Sale 精选【电视柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>The Fero 电视柜 exp与s to fit any space, from compact apartments to expansive 客厅s. Three deep 抽屉 glide open on quiet soft-close run…</p>
<ul>
<li>闪购精选 Exp与s from 71" to 110" to fit your space exactly, no matter the size</li>
<li>闪购精选 Three 抽屉 keeps remotes 与 cables tucked away instead of tangled up</li>
<li>闪购精选 Soft-close 抽屉 glide quietly so every touch ends 带 a gentle close</li>
<li>闪购精选 Crafted from FSC-certified wood, a responsible choice that feels as good as it looks</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/fba84dd2c9c3a805a2a3316380633cc6.jpg', 1, 325),
(2021, '毛绒胡桃木卧室家具款', 14, '<h3>毛绒胡桃木卧室家具款</h3>
<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Curva 毛绒 地板床 brings soft upholstery, a rounded headboard, 与 curved leg design into a sculptural 卧室 center件, balancing cozy comf…</p>
<ul>
<li>闪购精选 毛绒 upholstery wraps the frame 带 soft texture cozy daily comfort</li>
<li>闪购精选 Solid pine wood frame provides reliable support long-term nightly use</li>
<li>闪购精选 Carbon steel slats reinforce the base 与 help support the mattress</li>
<li>闪购精选 Rounded headboard creates a gentle backdrop reading, lounging, 与 rest</li>
<li>闪购精选 Curved legs add sculptural beauty 与 soften the overall 卧室 silhouette</li>
<li>闪购精选 Low platform profile creates a grounded look that feels clean 与 现代</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/10/09/a4792d81b5516d1936feacb64bb0ccf1.jpg', 1, 392),
(2022, '71"现代L型书桌款', 17, '<h3>71"现代L型书桌款</h3>
<p>Homary Flash Sale 精选【书桌】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Built executive offices or spacious home workspaces, this bold L型 书桌 brings focus, order, 与 presence to the room. The wide 书桌to…</p>
<ul>
<li>闪购精选 63" main 书桌top gives monitors, notes, 与 daily tools a generous place to stay ready</li>
<li>71" return creates a defined work zone, ma国王尺寸 the room feel organized 与 intentional</li>
<li>Three roomy 抽屉 keep files, stationery, 与 人al essentials neatly out of sight</li>
<li>Built- 柜子 储物 gives larger office items a home 带out crowding the 书桌top</li>
<li>闪购精选 Vented 柜子 helps improve airflow a computer tower or devices stored inside</li>
<li>闪购精选 Refined surface 与 sculptural base create a polished focal point 现代 workspaces</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/547b4c7517cd46a16dd5d244f2b33b54.jpg', 1, 453),
(2023, '63"岩板茶几款', 15, '<h3>63"岩板茶几款</h3>
<p>Homary Flash Sale 精选【茶几】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Designed 餐厅s 与 open-plan 厨房s, this sideboard supports daily dining, family gatherings, 与 厨房 储物 needs. The 岩板 top resists heat 与…</p>
<ul>
<li>Adjus桌子 shelves support flexible 储物 dinnerware 与 厨房 essentials</li>
<li>闪购精选 岩板 top resists heat, scratches, 与 stains easy daily cleaning</li>
<li>闪购精选 Wood 柜子 structure provides reliable support 与 lasting everyday durability</li>
<li>Sideboard fits 餐厅s, open-plan 厨房s, 与 现代 home layouts easily</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_40c7a88c6f05da177ab46134f1839019.jpg', 1, 187),
(2024, '35"悬浮弧形浴室柜款', 31, '<h3>35"悬浮弧形浴室柜款</h3>
<p>Homary Flash Sale 精选【浴室柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Defined by a 悬浮 silhouette 与 a curved half-circle form, the 浴室柜 套装 combines a durable stone resin top 与 generous 储物 to bring cl…</p>
<ul>
<li>悬浮 壁挂式 design maximizes floor space 与 creates a clean 现代 look</li>
<li>闪购精选 Stone resin top 与 水槽 offers durable, easy-care performance</li>
<li>Undermount 水槽 keeps the countertop loo国王尺寸 clean 与 seamless</li>
<li>Two 抽屉 与 one 柜子 keep toiletries neatly organized 与 accessible</li>
<li>闪购精选 Available multiple colors 与 directional options to suit different spaces 与 styles</li>
<li>Ready installation 带 st与ard single-hole 水龙头s 与 integrated overflow prevents accidental spillover</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 1, 106),
(2025, '模块柚木沙发款', 12, '<h3>模块柚木沙发款</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Turn your backyard into a luxurious retreat 带 this premium 柚木 户外 sectional. Crafted those who appreciate both style 与 durabilit…</p>
<ul>
<li>闪购精选 户外 & indoor use</li>
<li>7 件套 套装: This complete 套装 沙发 & 茶几 contains a total of 7 件套. 4 沙发s 与 3 茶几s, which can be freely combined to create scenarios 带 d…</li>
<li>闪购精选 Adap桌子 Modular Design</li>
<li>Premium 柚木 Craftsmanship 沙发 套装</li>
<li>【Cloud-Like Comfort】 水槽 into deep, generously padded cushions upholstered 户外 performance fabric that repels moisture 与 resists …</li>
<li>【Effortless Elegance】 带 its clean lines, warm 柚木 finish, 与 subtly curved armrests, this 沙发 blends 现代 sophistication 带 a relaxed…</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/4096x4096_e88371d883ecaf8325aee489e48f3220.jpg', 1, 1000),
(2026, 'Humply 59" 白色 皮质 9-抽屉 梳妆台', 14, '<h3>Humply 59" 白色 皮质 9-抽屉 梳妆台</h3>
<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Designed 现代 卧室s, Humply 梳妆台 performance PU 皮质 is ideal style-conscious homeowners, offering durable, easy-care 储物 that keeps cl…</p>
<ul>
<li>闪购精选 Performance PU 皮质 is spill-resistant, stain-resistant, 与 scratch-resistant easy upkeep</li>
<li>Multiple spacious 抽屉 keep clothes 与 essentials organized, tidy, 与 easy to access</li>
<li>闪购精选 Rounded 抽屉 fronts soften the silhouette while helping reduce bumps daily use</li>
<li>闪购精选 皮质-wrapped finish adds refined texture 与 delivers durable, low-maintenance appeal</li>
<li>现代 streamlined design elevates the room while adding practical concealed 储物</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c650adc2c9ffb688f8110be953c11b90.jpg', 1, 160),
(2027, '81"可转换丝绒沙发款', 12, '<h3>81"可转换丝绒沙发款</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>The modular sleeper 沙发 blends clean lines 带 flexible comfort 与 transforms into a cozy 床 minutes. Adjus桌子 backrests 与 headrests …</p>
<ul>
<li>Easy modular design switches smoothly between 沙发 与 床 modes</li>
<li>Soft 雪尼尔 丝绒 feels cosy 与 resists everyday scratches</li>
<li>闪购精选 Plush cushioning 带 high-density foam supports sit 与 sleep comfort</li>
<li>不锈钢 frame adds strength, stability, 与 a clean 现代 edge</li>
<li>闪购精选 Multiple layout options adapt easily to different rooms 与 routines</li>
<li>闪购精选 Compressed foam exp与s fully 带in 24-72 hours, 与 a quick steam treatment helps remove remaining creases a flawless look</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_c8beca0ba8fb1cde333cf205affe07a6.jpg', 1, 41),
(2028, '铝制餐桌椅款', 13, '<h3>铝制餐桌椅款</h3>
<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This thoughtfully designed 桌子 has a built- umbrella hole, allowing you to add shade 与 enjoy al fresco dining on sunny days. Its…</p>
<ul>
<li>【Frame】Sturdy 与 weather-resistant 灯weight 铝制 alloy ensures long-lasting 户外 durability, perfect all seasons</li>
<li>【桌子top】柚木 wood, a sustainable material that is 原木色ly moisture-resistant 与 resistant to warping or rotting</li>
<li>【Seating】铝制 frame 带 wood grain trim, offering sturdiness 与 rust-proof durability, ensuring long-lasting use</li>
<li>【Design】Features an umbrella hole, allowing you to easily add an 户外 umbrella sun protection or rain coverage, ma国王尺寸 it highly …</li>
<li>闪购精选 【Occasion】 Ideal al fresco dining, from family meals to entertaining guests</li>
<li>【Content】 餐桌*1, dining椅子s*6,Includes cushions 与 pillows</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 1, 1000),
(2029, 'Tevara 可转换 户外 组合沙发 套装 带 柚木 & 铝制 Frame, 灰色', 12, '<h3>Tevara 可转换 户外 组合沙发 套装 带 柚木 & 铝制 Frame, 灰色</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Transform your backyard into a relaxing retreat 带 the Tevara 现代 modular 户外沙发 套装. Crafted 带 premium 柚木 accents 与 durable, weathe…</p>
<ul>
<li>Adjus桌子 seat converts into a chaise lounge 人alized seating 与 lounging comfort</li>
<li>闪购精选 All-weather High-Performance Fabric delivers fade, water, mildew, stain, 与 scratch-resistant performance pet-friendly peac…</li>
<li>High-strength 铝制 alloy frame is 灯weight yet rust-resistant lasting 户外 stability</li>
<li>Premium 柚木 wood surface 带 原木色 oils resists weathering 与 aging lasting beauty, 带 subtle variations color 与 grain inherent to 原木色…</li>
<li>闪购精选 Flexible modular design lets you mix, match, 与 exp与 to fit spaces from small patios to large backyards</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_f9e1630c9d1d0fa37e2a8afdc6be68aa.jpg', 1, 141),
(2030, '悬浮毛绒卧室家具款', 14, '<h3>悬浮毛绒卧室家具款</h3>
<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Elevate your 卧室 带 the Curva 国王尺寸 床. Features no-shedding 毛绒, a wide headboard, 与 sturdy frame. Includes 悬浮 床头柜s 带 LED/wireless …</p>
<ul>
<li>智能 床头柜s 带 LED 与 wireless charging offer power 与 ambient glow</li>
<li>No-shedding 白色 毛绒 与 a wide headboard provide soft, durable comfort</li>
<li>闪购精选 Sturdy eucalyptus frame 与 carbon steel slats ensure long-lasting stability</li>
<li>闪购精选 落地式 platform design eliminates box springs a clean, simple look</li>
<li>闪购精选 This product is sold 带out a mattress, allowing you to choose one that best suits your preferences</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/25/2500x2500_13e80149379d6220493ee0e264608b6b.jpg', 1, 159),
(2031, 'Slatera 户外 金合欢木 & 铝制 模块沙发 套装 Dark 灰色', 12, '<h3>Slatera 户外 金合欢木 & 铝制 模块沙发 套装 Dark 灰色</h3>
<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Blending modular flexibility 带 warm 金合欢木 accents, Slatera 组合沙发 套装 brings durable comfort 与 a more versatile layout to patios, d…</p>
<ul>
<li>Powder-coated 铝制 frame resists rust 与 weather reliable 户外 use</li>
<li>FSC-certified 金合欢木 accents add 原木色 warmth 带 responsibly sourced appeal</li>
<li>闪购精选 Modular sections can form a sectional or 日床-style layout to suit your space</li>
<li>Water-resistant fabric helps h与le 灯 moisture 与 everyday 户外 messes</li>
<li>Built- side 桌子s keep drinks, books, 与 essentials conveniently 带in reach</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_c310ad7ee843c59e6d3c496917427212.jpg', 1, 190),
(2032, 'Glowin K1 智能马桶 带 加热 Seat & Rear Ambient 灯, 1.32 GPF', 33, '<h3>Glowin K1 智能马桶 带 加热 Seat & Rear Ambient 灯, 1.32 GPF</h3>
<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Elevate your 浴室 style 带 this ultra-现代 Elongated One-件 白色 智能 Toilet. The 加热 seat comes 带 temperature control, while the self-cle…</p>
<ul>
<li>加热 Seat 带 Adjus桌子 Temperature: Comfort throughout the year</li>
<li>闪购精选 Self-Cleaning Bidet Nozzle: Adjus桌子 water pressure 与 temperature</li>
<li>闪购精选 Water-Saving 1.32 GPF Flush: Eco-friendly 带 efficient performance</li>
<li>闪购精选 Soft-Close Lid & Auto Open/Close: Convenience 带 quiet operation</li>
<li>闪购精选 Remote Control Operation: Full control at your fingertips</li>
<li>闪购精选 Rear Ambient 灯: Soft illumination guides nighttime visits</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 1, 1),
(2033, '59"双人岩板浴室柜款', 31, '<h3>59"双人岩板浴室柜款</h3>
<p>Homary Flash Sale 精选【浴室柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Aro 浴室柜 pairs a 岩板 countertop 带 a ceramic undermount 水槽, offering generous 储物 与 a clean 现代 look master baths, guest baths, 与 po…</p>
<ul>
<li>闪购精选 岩板 countertop adds a durable, easy-clean surface daily use</li>
<li>Ceramic undermount 水槽 keeps the 浴室柜 top smooth, neat, 与 easy to wipe</li>
<li>Multiple 抽屉 与 柜子s provide ample 储物 everyday essentials</li>
<li>Soft-close 抽屉 与 doors reduce noise a smoother 浴室 routine</li>
<li>Ready installation 带 st与ard 水龙头 hole 与 integrated overflow prevents accidental spillover</li>
<li>闪购精选 Available multiple colors, sizes, 与 single or double 水槽 options</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 1, 243),
(2034, '63"田园可伸缩胡桃木餐桌椅款', 13, '<h3>63"田园可伸缩胡桃木餐桌椅款</h3>
<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Designed flexible dining, this 田园风 可伸缩 餐桌 exp与s weekday meals or guests, 带 a wood-look top 与 a metal 与 engineered wood base a w…</p>
<ul>
<li>可伸缩 餐桌 adjusts easily daily meals, family visits, or extra guests</li>
<li>Wood-look 桌子top brings 田园风 warmth 带out ma国王尺寸 the 餐厅 feel heavy</li>
<li>Metal 与 engineered wood base adds s桌子 support while keeping leg space comfor桌子</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/09/1600x1600_2cd0ae20465f41f320da1d6b4101fd08.jpg', 1, 160),
(2035, '皮质卧室家具款', 14, '<h3>皮质卧室家具款</h3>
<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Humply 床头柜 features a curved silhouette that brings a soft, 现代 touch to the 卧室. It combines integrated charging 与 practical 储物 …</p>
<ul>
<li>Eco-friendly engineered wood wrapped 科技皮 delivers a refined 与 durable finish</li>
<li>科技皮 offers water, stain, 与 scratch resistance effortless everyday maintenance</li>
<li>闪购精选 Built- charging station includes USB, Type-C, 与 wireless charging convenient power access</li>
<li>Spacious 抽屉 provide ample 储物 daily essentials 与 卧室 items</li>
<li>闪购精选 Delivered fully assembled, ready to use right out of the box 带 no installation required</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/aee18aa35e9368a30339efb69488e7db.jpg', 1, 1),
(2036, '39"日式简约可伸缩胡桃木餐桌椅款', 13, '<h3>39"日式简约可伸缩胡桃木餐桌椅款</h3>
<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Ideal daily dining, family gatherings, or small spaces,this 可伸缩 餐桌 transitions from round to oval, seating up to 6 people. Made…</p>
<ul>
<li>This 可伸缩 餐桌 exp与s from round to oval, seating up to 6 family meals</li>
<li>闪购精选 Solid wood construction ensures long-lasting durability 与 stability</li>
<li>闪购精选 Ideal small spaces, offering stylish seating 带out compromising functionality</li>
<li>日式简约-inspired design adds 现代 elegance to any 厨房 or dining area</li>
<li>The round 桌子 design offers added safety, ma国王尺寸 it ideal families 带 children</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_21071fa7feb62ad532c7fe1283741f50.jpg', 1, 453),
(2037, '37"客厅家具款', 11, '<h3>37"客厅家具款</h3>
<p>Homary Flash Sale 精选【客厅家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Transform cramped entryways into organized spaces 带 this versatile shoe 柜子 that extends when you need more room 与 swivels to se…</p>
<ul>
<li>Extend the main 柜子 extra shoe 储物 or collapse it to save space</li>
<li>闪购精选 Swivel the side unit to create a h与y bench, then tuck it away when not needed</li>
<li>闪购精选 Durable rubberwood panels resist daily wear while adding 原木色 visual appeal</li>
<li>Adjus桌子 shelves customize 储物 different shoe heights, from flats to boots</li>
<li>闪购精选 Rounded corners on all edges help prevent bumps 与 injuries busy homes</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 1, 325),
(2038, '118"庭院遮阳款', 24, '<h3>118"庭院遮阳款</h3>
<p>Homary Flash Sale 精选【庭院遮阳】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Transform your 户外 space 带 this 118" cantilever umbrella designed 现代 patio living. Built 带 a sturdy 铝制 frame, UV-resistant water…</p>
<ul>
<li>闪购精选 360°rotating canopy lets you adjust shade direction freely throughout the day continuous sun protection</li>
<li>Rust-resistant 铝制 frame 与 waterproof fade-resistant canopy ensure long-lasting 户外 performance all seasons</li>
<li>闪购精选 Off套装 cantilever design provides wide uninterrupted shade 带out a center pole, maximizing usable patio space</li>
<li>闪购精选 8.1 oz UPF 30+ polyester canopy blocks over 97% of UV rays to protect skin 与 户外 furniture</li>
<li>闪购精选 220 lb granite base keeps the umbrella firmly s桌子 与 prevents tipping winds up to 25 mph</li>
<li>闪购精选 Pulley lift system allows one-人 smooth opening 与 closing of the canopy 带 minimal effort</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 1, 43),
(2039, '6-灯 LED Linear 厨房岛台 灯ing 金色 带 Glass Globe Shade Dimmable', 41, '<h3>6-灯 LED Linear 厨房岛台 灯ing 金色 带 Glass Globe Shade Dimmable</h3>
<p>Homary Flash Sale 精选【吸顶灯】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>This linear 岛台 灯 features a minimalist LED strip 与 glass globe design, cleverly combined to create a chic statement. This 现代 ve…</p>
<ul>
<li>闪购精选 Wave-shaped 金色 frame 带 crystal globe accents</li>
<li>闪购精选 Built- LED 灯s</li>
<li>闪购精选 High-quality materials ensure long-lasting beauty 与 functionality</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_fb975dc166c10e23da4ab28783647699.jpg', 1, 1),
(2040, '绳编餐桌椅款', 13, '<h3>绳编餐桌椅款</h3>
<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Designed relaxed garden living, this 8-seat patio dining 套装 features a weather-resistant 铝制 桌子 与 h与-woven 绳编 椅子s. Built backyar…</p>
<ul>
<li>闪购精选 Weather-resistant 铝制 frame resists rust 与 UV rays, ensuring lasting durability garden</li>
<li>闪购精选 H与-woven all-weather rope resists fading 与 moisture, keeping its texture season after season</li>
<li>闪购精选 Removable cushion covers water-resistant fabric make cleaning up spills simple 与 stress-free</li>
<li>闪购精选 Seat cushions 带 plush padding provide comfor桌子 support long meals garden</li>
<li>闪购精选 Generous 8-seat layout accommodates family gatherings 与 dinner parties 带 room everyone</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6b080a113c3048c7ad7e6ac555f79264_.jpg', 1, 197),
(2041, 'Mordel 63"-94" 可伸缩 胡桃木 电视柜 带储物', 18, '<h3>Mordel 63"-94" 可伸缩 胡桃木 电视柜 带储物</h3>
<p>Homary Flash Sale 精选【电视柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>
<p>Designed 现代 homes, Mordel 可伸缩 电视柜 adjusts from 63″ to 94″ 与 pairs clean lines 带 hidden 储物, adapting easily from compact spaces …</p>
<ul>
<li>闪购精选 Extends from 63″ to 94″ flexible placement different spaces</li>
<li>闪购精选 Scratch-resistant surface helps maintain a clean, refined look</li>
<li>闪购精选 Spacious 储物 keeps media gear 与 daily essentials organized</li>
<li>闪购精选 Push-to-open doors create a sleek, h与le-free profile</li>
<li>闪购精选 FSC-certified wood 与 an anti-slip steel base add lasting support</li>
</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_e6525b6402e21f66cfb8dabdeb07db40.jpg', 1, 1);

INSERT INTO t_spu_spec (spu_id, spec_name, spec_values) VALUES
(2001, '颜色', '默认款'),
(2002, '颜色', '默认款'),
(2003, '颜色', '默认款'),
(2004, '颜色', '默认款'),
(2005, '颜色', '默认款'),
(2006, '颜色', '默认款'),
(2007, '颜色', '默认款'),
(2008, '颜色', '默认款'),
(2009, '颜色', '默认款'),
(2010, '颜色', '默认款'),
(2011, '颜色', '默认款'),
(2012, '颜色', '默认款'),
(2013, '颜色', '默认款'),
(2014, '颜色', '默认款'),
(2015, '颜色', '默认款'),
(2016, '颜色', '默认款'),
(2017, '颜色', '默认款'),
(2018, '颜色', '默认款'),
(2019, '颜色', '默认款'),
(2020, '颜色', '默认款'),
(2021, '颜色', '默认款'),
(2022, '颜色', '默认款'),
(2023, '颜色', '默认款'),
(2024, '颜色', '默认款'),
(2025, '颜色', '默认款'),
(2026, '颜色', '默认款'),
(2027, '颜色', '默认款'),
(2028, '颜色', '默认款'),
(2029, '颜色', '默认款'),
(2030, '颜色', '默认款'),
(2031, '颜色', '默认款'),
(2032, '颜色', '默认款'),
(2033, '颜色', '默认款'),
(2034, '颜色', '默认款'),
(2035, '颜色', '默认款'),
(2036, '颜色', '默认款'),
(2037, '颜色', '默认款'),
(2038, '颜色', '默认款'),
(2039, '颜色', '默认款'),
(2040, '颜色', '默认款'),
(2041, '颜色', '默认款');

INSERT INTO t_sku (spu_id, spec_json, price, stock, image, sku_code) VALUES
(2001, '{"颜色": "默认款"}', 499.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_68018454ad18e690bce4b73791d09d1b.jpg', 'FS200101'),
(2002, '{"颜色": "默认款"}', 2999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/30/2500x2500_563885afd3a8fad87e374fb6d2743819.jpg', 'FS200201'),
(2003, '{"颜色": "默认款"}', 1699.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 'FS200301'),
(2004, '{"颜色": "默认款"}', 1059.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_776c68b2df6c5982e6f8940dc554d301.jpg', 'FS200401'),
(2005, '{"颜色": "默认款"}', 2999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/10/ca2b2248d9f08dac420975b5b2761632.jpg', 'FS200501'),
(2006, '{"颜色": "默认款"}', 2889.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/ad7d891b853f1eda6eedb43a14a1bc63.jpg', 'FS200601'),
(2007, '{"颜色": "默认款"}', 1199.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_d381d45f3b2b3f52b2913af302cef9d0.jpg', 'FS200701'),
(2008, '{"颜色": "默认款"}', 719.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_8bd9e87f49e2482713fc3ab7f482bcc3.jpg', 'FS200801'),
(2009, '{"颜色": "默认款"}', 1659.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/06/03/7aef181a1ba049c2bffe4341ab23b8be.jpg', 'FS200901'),
(2010, '{"颜色": "默认款"}', 2199.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/9fbc03b404081fe1d1051daa11c0b1ef.jpg', 'FS201001'),
(2011, '{"颜色": "默认款"}', 489.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 'FS201101'),
(2012, '{"颜色": "默认款"}', 999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/1600x1600_d441d16a02baa02b59a4c2a9fa071edc.jpg', 'FS201201'),
(2013, '{"颜色": "默认款"}', 2299.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F4dbcf8ad6a4949639f30536645394236_.jpg', 'FS201301'),
(2014, '{"颜色": "默认款"}', 2099.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 'FS201401'),
(2015, '{"颜色": "默认款"}', 1699.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/1f3bc4195f48b9305df8370fdbc87550.jpg', 'FS201501'),
(2016, '{"颜色": "默认款"}', 779.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_562a03bcaece63c7d0ce6cc5d6dea758.jpg', 'FS201601'),
(2017, '{"颜色": "默认款"}', 1099.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 'FS201701'),
(2018, '{"颜色": "默认款"}', 4299.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba661f0bcb8f8633e675b2e19034dca5.jpg', 'FS201801'),
(2019, '{"颜色": "默认款"}', 799.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a891337a4dd015aa12e8f002336146e0.jpg', 'FS201901'),
(2020, '{"颜色": "默认款"}', 469.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/fba84dd2c9c3a805a2a3316380633cc6.jpg', 'FS202001'),
(2021, '{"颜色": "默认款"}', 1749.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/10/09/a4792d81b5516d1936feacb64bb0ccf1.jpg', 'FS202101'),
(2022, '{"颜色": "默认款"}', 1899.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/547b4c7517cd46a16dd5d244f2b33b54.jpg', 'FS202201'),
(2023, '{"颜色": "默认款"}', 779.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_40c7a88c6f05da177ab46134f1839019.jpg', 'FS202301'),
(2024, '{"颜色": "默认款"}', 849.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 'FS202401'),
(2025, '{"颜色": "默认款"}', 4499.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/4096x4096_e88371d883ecaf8325aee489e48f3220.jpg', 'FS202501'),
(2026, '{"颜色": "默认款"}', 979.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c650adc2c9ffb688f8110be953c11b90.jpg', 'FS202601'),
(2027, '{"颜色": "默认款"}', 789.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_c8beca0ba8fb1cde333cf205affe07a6.jpg', 'FS202701'),
(2028, '{"颜色": "默认款"}', 3029.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 'FS202801'),
(2029, '{"颜色": "默认款"}', 2699.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_f9e1630c9d1d0fa37e2a8afdc6be68aa.jpg', 'FS202901'),
(2030, '{"颜色": "默认款"}', 2199.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/25/2500x2500_13e80149379d6220493ee0e264608b6b.jpg', 'FS203001'),
(2031, '{"颜色": "默认款"}', 999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_c310ad7ee843c59e6d3c496917427212.jpg', 'FS203101'),
(2032, '{"颜色": "默认款"}', 529.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 'FS203201'),
(2033, '{"颜色": "默认款"}', 1359.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 'FS203301'),
(2034, '{"颜色": "默认款"}', 1159.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/09/1600x1600_2cd0ae20465f41f320da1d6b4101fd08.jpg', 'FS203401'),
(2035, '{"颜色": "默认款"}', 239.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/aee18aa35e9368a30339efb69488e7db.jpg', 'FS203501'),
(2036, '{"颜色": "默认款"}', 849.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_21071fa7feb62ad532c7fe1283741f50.jpg', 'FS203601'),
(2037, '{"颜色": "默认款"}', 569.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 'FS203701'),
(2038, '{"颜色": "默认款"}', 1279.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 'FS203801'),
(2039, '{"颜色": "默认款"}', 219.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_fb975dc166c10e23da4ab28783647699.jpg', 'FS203901'),
(2040, '{"颜色": "默认款"}', 3879.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6b080a113c3048c7ad7e6ac555f79264_.jpg', 'FS204001'),
(2041, '{"颜色": "默认款"}', 299.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_e6525b6402e21f66cfb8dabdeb07db40.jpg', 'FS204101');

INSERT INTO t_spu_image (spu_id, image_url, sort) VALUES
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_68018454ad18e690bce4b73791d09d1b.jpg', 0),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_3094a083fb29f5c6c038919bd98f54e7.jpg', 1),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_be5c73cf98c52ca552972f0d6f627df5.jpg', 2),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/3000x3000_a40719ca8719ffe2404d2185d99b6464.jpg', 3),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/3000x3000_dc1edbc61c7e5f5387e4dc207f7d0b08.jpg', 4),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_af368378b3a76f4c2d5f437986e8dc8e.jpg', 5),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/3000x3000_9ab53ef0701abb4439a7f79993581042.jpg', 6),
(2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_3ddcc0e2c2a61d1bb3b671b38b71a5dc.jpg', 7),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/30/2500x2500_563885afd3a8fad87e374fb6d2743819.jpg', 0),
(2002, 'https://img5.su-cdn.com/mall/file/2024/09/03/5c4b95e4c9d4f78df8df53626d5287c6.mp4', 1),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/07/2500x2500_d746723e3d1a1b6ca98f59ace0a040ca.jpg', 2),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/28/2500x2500_ac512150521dbc9a52e3437fdc83bff9.jpg', 3),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/28/1500x1500_bb6c09a223632878028becbf5473107a.jpg', 4),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_645a71e866934953fb50a6a6d939f808.jpg', 5),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/25/2500x2500_a219b42398a7c956cd1c2e6aab01f44f.jpg', 6),
(2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/16/2500x2500_0aa12a2b4ba978696e56d90f926a63b9.jpg', 7),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 0),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/05/14/339d705611a2d6b7374b1b8ad0939c7e.jpg', 1),
(2003, 'https://img5.su-cdn.com/mall/file/2024/05/17/1353d11c73c6ef46a42fea5cf46a0d48.mp4', 2),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_3db13eb227bf5be2e79fa11a3c2b0be2.jpg', 3),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_07c803e4c6ff787843460220516d36bd.jpg', 4),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_32533b101cf04bcce44fb0704ffb0071.jpg', 5),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_bce6ca472d04bcb9b43c049b25ba044d.jpg', 6),
(2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/29/2500x2500_ec71045a7886738a15c36f2423ef3d0a.jpg', 7),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_776c68b2df6c5982e6f8940dc554d301.jpg', 0),
(2004, 'https://img5.su-cdn.com/mall/file/2025/09/18/64062048e0eec36411ac265a4adcd01e.mp4', 1),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_049823d50a0dccb34d8bf715b154fb09.jpg', 2),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_cd377f94b6e86b726451273f3dd4ebdf.jpg', 3),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_61c7595923570ec76ab03e9e832224db.jpg', 4),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fa8f03b4e1f2e4c59a7ffcf22a0ad45bb_.jpg', 5),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/06/2500x2500_22ad4c0081b4d93bdd6d357c279bcc7c.jpg', 6),
(2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/28/2500x2500_2b0d963bd6c11d84eedd6a615964ab11.jpg', 7),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/10/ca2b2248d9f08dac420975b5b2761632.jpg', 0),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_c95b942e70a3a6d37a7961aab902691a.jpg', 1),
(2005, 'https://img5.su-cdn.com/mall/file/2024/05/29/98c6bfee71207d5495bbb8eb78b77c9e.mp4', 2),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_7c4b5c026c6b8c0d021acd114854b9d0.jpg', 3),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_73c13385a48d683932ef3210db3677b8.jpg', 4),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/16/1600x1600_082d50d94631b29fd32919156b66269c.jpg', 5),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_09d8f19cd0936c8d3ea31d132b1b0c0c.jpg', 6),
(2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_e8a26bbcc85e2849462dd2ba09fc8bf0.jpg', 7),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/ad7d891b853f1eda6eedb43a14a1bc63.jpg', 0),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/970cd7877e8367fcb005aab248383b5c.jpg', 1),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/27/2500x2500_7a5fe481f4667655cba2da9b686d671b.jpg', 2),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/11/4e258cf592a2b7e419619192619e393d.jpg', 3),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/11/14a8062bf9716da145dfbcffd132e515.jpg', 4),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/02/7f888bf8bded9200623ffd10adf60471.jpg', 5),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/11/887f51987e67f4ec9f2b2010e508311c.jpg', 6),
(2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/cba44c3d47ca5b6176673e62f6b3a0e6.jpg', 7),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_d381d45f3b2b3f52b2913af302cef9d0.jpg', 0),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_3d0b41129fd78b68b6fa218b3549f2f9.jpg', 1),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_3ae6dde7d14120ed18729f87e7df50dc.jpg', 2),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/25/2500x2500_db6c18d39095fb10a3482f74c11b5bf3.jpg', 3),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_4e7a581d12e79d234a238d21bcc5e17b.jpg', 4),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_44001a09ae23f640dba7896b837663ca.jpg', 5),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_2da31891069e6bfe54fe1054ec7cc214.jpg', 6),
(2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_81dc10cc5b3af9d2cf2531224d8c5489.jpg', 7),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_8bd9e87f49e2482713fc3ab7f482bcc3.jpg', 0),
(2008, 'https://img5.su-cdn.com/mall/file/2024/09/12/8481e3d1b55201d57b3ba381bf6a6a60.mp4', 1),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/20/2500x2500_92d1d2655b846f2ab1e99d8385e5f2bd.jpg', 2),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/08/2500x2500_222d1b241a43524424f710193e697d9a.jpg', 3),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/21/2500x2500_9d306a08c63b6736af2d5421e4df35b1.jpg', 4),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/05/2500x2500_d477825dca1f73fd6965af6e20744705.jpg', 5),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/04/29/4f274228e034fb4f64c03b7e2dfb864a.jpg', 6),
(2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/08/2500x2500_2f94b037d55cb6aa9eca59d8c7d4c650.jpg', 7),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/06/03/7aef181a1ba049c2bffe4341ab23b8be.jpg', 0),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/05/17/596f966d8392d06c289e6ae063827014.jpg', 1),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/07/66a27221d50f495dab9effc2b04c1094.jpg', 2),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/07/e208dd18318067a9ba77bd15debddfde.jpg', 3),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/05/64b5263fcd4dcea449dd352801de6944.jpg', 4),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/08/08/56a6d6f6f0a538ec8465970a76c658d2.jpg', 5),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/23/72f0222ed94dcd920f55fd96e01408e0.jpg', 6),
(2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/05/159216cb1392a95b6f4d19d58dbf5f29.jpg', 7),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/9fbc03b404081fe1d1051daa11c0b1ef.jpg', 0),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/f95cc47fa9c2c3dec08aa223c72e2ea2.jpg', 1),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/37086c29e029ec2c3b0c1558f5bbc81b.jpg', 2),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/dbd9866ecd710ad29cafbbbedcc5c2f3.jpg', 3),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/17/2500x2500_e41754d0f0e16a6e3ad881d25d23d167.jpg', 4),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/05/1000x1000_e0c01adadedf5449514fbc68e064326e.jpg', 5),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/17/2500x2500_c5cff504466b3eb7ac3f7e79b2b1cb4d.jpg', 6),
(2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/27/2500x2500_238cf64c9a3e6dae06d405545b756a17.jpg', 7),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 0),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_36933681c4031f1c5d29d0636703ea6a.jpg', 1),
(2011, 'https://img5.su-cdn.com/mall/file/2024/08/07/5f43a4732b63d34423b5f6752a1b3edc.mp4', 2),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_b003a2a250930cacb7110cbf6437f35c.jpg', 3),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/25/1000x1000_231474df6f1dc9ca824e9b9057930171.jpg', 4),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_e8bfcc06ba4a50e855f3ad7309dddbde.jpg', 5),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_bc1b240d0e8070878427454f3721bef9.jpg', 6),
(2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/04/1000x1000_46c70421fbb89e153892f6cf5a46ac9f.jpg', 7),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/1600x1600_d441d16a02baa02b59a4c2a9fa071edc.jpg', 0),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_b6182735226188dd0d8f69ef34900b06.jpg', 1),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/17/2500x2500_f77beb960d3b240bc7721b674ba51b4e.jpg', 2),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F97ad12642fed4c7080ad1b2461d456b4_.jpg', 3),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_aab38927c84a26d48ce7f67492f69e34.jpg', 4),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_e1998d372b245328967cbd46b218b947.jpg', 5),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_b56cd8a3ad06a4f46c7b8251ff51cf9d.jpg', 6),
(2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_de52b2fbc4197a5ff59abeeb91f0ea74.jpg', 7),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F4dbcf8ad6a4949639f30536645394236_.jpg', 0),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fdb741e8c54bf468a88e299a89468d40e_.jpg', 1),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fa079e76159424581b6b43927a6443c9d_.jpg', 2),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/24/2500x2500_0b305226115c671d3d4ebe5a4ad91f33.jpg', 3),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F30285e4590334fe7ad73573859d2f6b0_.jpg', 4),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/14/2500x2500_3d2f3622b26516d0295d33d3ca1abe41.jpg', 5),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F8d40c0eb85134fe1bcb0203a92444f24_.jpg', 6),
(2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6dd113cdab3b48558b5b497307ed0db8_.jpg', 7),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 0),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_192876324e63edaf20ab9b7e6f0ffca0.jpg', 1),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_dbb10e6aeeb2e75a9723630018dcad0e.jpg', 2),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_c7c8a1f51734b2b694b4c413092000af.jpg', 3),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/5000x5000_4c8cbdf052330bda7126583b83ea89a8.jpg', 4),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_42940d3fd15016e0044a369e962389eb.jpg', 5),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/13/2500x2500_001777e289ff12a78dfa4f26f230dce7.jpg', 6),
(2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/5000x5000_17eccee545c9da97af9e3fe9ca8a4ce6.jpg', 7),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/1f3bc4195f48b9305df8370fdbc87550.jpg', 0),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/2768d37e4636f4419f10f07aa5e6a1c4.jpg', 1),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/e7fbfb52c78092122d8db4493fcb6aed.jpg', 2),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/55eebc431881eed94751487f2376c12b.jpg', 3),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/81fd466ebc30f8b3c52fa281856774bb.jpg', 4),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/17/2500x2500_5be6248f205253d50297aebeed06ef54.jpg', 5),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/08/09/9abdde37f6f2be0b47eefca6c7689a36.jpg', 6),
(2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/08/09/84f79d24b713a1dbdc674f995f0dc5f2.jpg', 7),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_562a03bcaece63c7d0ce6cc5d6dea758.jpg', 0),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/06/2500x2500_f54c22946b2bbf2d558c25c4fa18add7.jpg', 1),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_bd5d433b732ed37d0bce8de7e21d210d.jpg', 2),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_3df74fcdb2e17daa947f0ec1182b53aa.jpg', 3),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/08/2500x2500_e6689bd1a6b63b050b70f8de78cc5f85.jpg', 4),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/08/2500x2500_7688be5462c76c6cd4be5679b6b83ba5.jpg', 5),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/11/1000x1000_7c2f081869dbc5db342bb2daf8ed83ab.jpg', 6),
(2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_23926cd99d6a8e704f5987b304a89d12.jpg', 7),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 0),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_2161d3874793806b412050732dafed7f.jpg', 1),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_921e15444c8b861c85520d9e33e14f1d.jpg', 2),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_f46e4ac27079f2e78cf77f08f3b47784.jpg', 3),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_7cd040a4402e7905d4150407e058fdc8.jpg', 4),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/3000x3000_7f25974ec56364e9af6e738371ef609c.jpg', 5),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_a5a61532823862fb75581dfaa4522b0a.jpg', 6),
(2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_b4e85e6146594adf66437dfb23d1ccdf.jpg', 7),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba661f0bcb8f8633e675b2e19034dca5.jpg', 0),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_d650c6c97a2eb2358efc7401410d5b41.jpg', 1),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_83c3ee7816bfa8c4198327b11876610a.jpg', 2),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_7a5b8da58208eb30527455419aac6728.jpg', 3),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_1fa6a8b3113cd23786d0217106fce39e.jpg', 4),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba21f70dded5e7a54311bc154be2d570.jpg', 5),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_0097fb57c85cf57189126e75e3e31b79.jpg', 6),
(2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/05/29/85a0ed0c7b34aa60b56a2e6be77f68f4.jpg', 7),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a891337a4dd015aa12e8f002336146e0.jpg', 0),
(2019, 'https://img5.su-cdn.com/mall/file/2023/11/10/bbae9bdb56cb4b01ef5628c174dbbcf6.mp4', 1),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/692c504c97b96d2c3753ab4d61226432.jpg', 2),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/b4d97167f3d66147aaac3a79b71c434c.jpg', 3),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/02fb2cef8bc2ed13460fa86f26f0cd38.jpg', 4),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a63aa874cd64463073484b705ec863f4.jpg', 5),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/2/2024/06/28/1000x700_30f877255f61834b4cb4dc67c48c0fe4.jpg', 6),
(2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/4946ed750021e4435aa02fef4049c2d4.jpg', 7),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/fba84dd2c9c3a805a2a3316380633cc6.jpg', 0),
(2020, 'https://img5.su-cdn.com/mall/file/2025/05/15/721a815d19230e1b53e2ba8862b2888c.mp4', 1),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/bd36e32dde14e6ff855619da735c66d7.jpg', 2),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/18a2b1bf4330798017d74cf7242d96e5.jpg', 3),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/13/2500x2500_0ae590fb5c3dc2b90d4b26d28e27d595.jpg', 4),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/05/2500x2500_f227850e0b747fd0d242f3f28dfa4a25.jpg', 5),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/23/2500x2500_5d8363115490400fd0cc0f2920f246c4.jpg', 6),
(2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/23/2500x2500_147f461220acd66b137c8c88551822c1.jpg', 7),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/10/09/a4792d81b5516d1936feacb64bb0ccf1.jpg', 0),
(2021, 'https://img5.su-cdn.com/mall/file/2024/01/16/8a565d4e27420356a4ec60170f56dcde.mp4', 1),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/2500x2500_13f20a77beb3085e86d0d8928334d811.jpg', 2),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/2500x2500_edccdfa0e8a99b4f2ac977197b61d40a.jpg', 3),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/2500x2500_5c9bcf1a4b210912bacc03dbad74a905.jpg', 4),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/27/2500x2500_bf15815ba81e5b5d973e3e4cf1cb8df7.jpg', 5),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/25/2500x2500_0a354a693d31b5a7337c621789ebd22c.jpg', 6),
(2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/27/2500x2500_ca056ef6d24b55874c34023732dbd4c2.jpg', 7),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/547b4c7517cd46a16dd5d244f2b33b54.jpg', 0),
(2022, 'https://img5.su-cdn.com/mall/file/2022/12/02/08de99f62f339829fb31854e4fec39b1.mp4', 1),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/10/1500x1500_aa298202caee8032337f8b37743430dd.jpg', 2),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/01/1a43134662acfc4cb8bec51b09186bd5.jpg', 3),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/0b5b41ef8a56dc9c020c41dd09e249bb.jpg', 4),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/01/5c0e8dbb6066ad4ea203a0b6cbb84378.jpg', 5),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/29/2500x2500_5aba18f02b1254443d9e5576c670c694.jpg', 6),
(2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/01/d3ba83f6374d527819b165590b1aa653.jpg', 7),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_40c7a88c6f05da177ab46134f1839019.jpg', 0),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_1bcd9843f9f2eb68e7a129162ab20721.jpg', 1),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_98d46646a4fbcfff06f84dc38564b84e.jpg', 2),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_1429f33a67ec8708e28dc09eb9b84e7f.jpg', 3),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/10/2500x2500_65559eb3ffb30999a37f4dbb37a5d006.gif', 4),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_ca601c53d7b4ca6a76656ef1712c0d5e.jpg', 5),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/10/2500x2500_bda98d7b8e34edb11bf44e3f76d8add2.jpg', 6),
(2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/10/2500x2500_00516e3792b287101649aba94d7af914.jpg', 7),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 0),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_5b152e78f6a507f8382686fb0a235eca.jpg', 1),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_53149ed84c2ca6979d505d5a0b68d2ce.jpg', 2),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_c5229094144cb74e0ec7bbc3842fb291.jpg', 3),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_b4d38a91d590af46b110e9773a7b0883.jpg', 4),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/05/2500x2500_7a29028e712242ced3fc60f1063951cc.jpg', 5),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_765eb7408f8567f6cd08e1698fe7c796.jpg', 6),
(2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_9ff3c4fa38538eabf19a78a229116a61.jpg', 7),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/4096x4096_e88371d883ecaf8325aee489e48f3220.jpg', 0),
(2025, 'https://img5.su-cdn.com/mall/file/2026/01/20/4f4838e44a9c29754af8b0c6170c373e.mp4', 1),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_63b99e5bd8ce8a475c765ca8b34f9884.jpg', 2),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_879ac88aa3cc07274c192054d0df1890.jpg', 3),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_244f90ae55fff24492ebd8bd277871e2.jpg', 4),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_e13bff1c61bfb53f67eb15a40eb16e9e.jpg', 5),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/11/2500x2500_53261b54a43edd0a6c4e6724606a4ff8.jpg', 6),
(2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_61ad5f414fbd094f42fb2f2b682185d3.jpg', 7),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c650adc2c9ffb688f8110be953c11b90.jpg', 0),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_e134302d00f171d0e008b2165921e867.jpg', 1),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c52e5d4fd6ea2dbe8f0b1ebac1eb546e.jpg', 2),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_e7f5d12ca236f25b2af4000caf7eb39d.jpg', 3),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_e5d998a7df966d9fe8534090256c3bb2.jpg', 4),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_5083a07d09473af4407dc81c294e2f8c.jpg', 5),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_d9e41b4dd89a8b062aece7030958f7b8.jpg', 6),
(2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_8b04244e7e764e2247605c5a0feede3a.jpg', 7),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_c8beca0ba8fb1cde333cf205affe07a6.jpg', 0),
(2027, 'https://img5.su-cdn.com/mall/file/2025/02/14/ab2a9723959c6193792a4ef6091cdf67.mp4', 1),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_2467eca3bfaf5ca8dd6ee4e6a0582295.jpg', 2),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2460x2460_21db4578eddc4688bf494da2f56abbd2.jpg', 3),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_ad2eaced45d691d5a494ab2b09bd7f5a.jpg', 4),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_041e2a11a20e4554e64b95a26b0eb73b.jpg', 5),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/3000x3000_48abb34c8a07ab5908fad9db158ff0f4.jpg', 6),
(2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_b6021b6a81ce5da1c8466ae342683d48.jpg', 7),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 0),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_9f56f07329945c917b71e06b85ebecbe.jpg', 1),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_db3d641d0c25844265fe6cbbd4fe8ba3.jpg', 2),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/25/2500x2500_73763ca1c1be8daeb5e763de6d98a4b1.jpg', 3),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_babd7409043946f5bdd5755541e5aeff.jpg', 4),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/16/2500x2500_92cd4c585365079b73e56b44f47886cb.jpg', 5),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_b99fe4299148176bb0c4d33803c3c944.jpg', 6),
(2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_661a710fd6086a57d0ecdbb237b6b521.jpg', 7),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_f9e1630c9d1d0fa37e2a8afdc6be68aa.jpg', 0),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_a2abd0ffbac1e360344521a214ef5ed0.jpg', 1),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/21/2500x2500_20490fa69328d2095cba48d4bf036840.jpg', 2),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_2d0e34148f5ae61b128447c5e19b1562.jpg', 3),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/21/2500x2500_ebe531c0ece0eeca8556a8b8691be17e.jpg', 4),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_f56b7afa709ec78c24cd1ad334d0c087.jpg', 5),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_c10e1a42b3147f74e6d18485e9e64cae.jpg', 6),
(2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_0b4334f7be605d79061e262a0cff582b.jpg', 7),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/25/2500x2500_13e80149379d6220493ee0e264608b6b.jpg', 0),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_09165adc778096ae3e5d0053e007b2e4.jpg', 1),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_d3dc5ed5904eff3bb4ade410c47c26d3.jpg', 2),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_c4c1dcab5a275cf5c3afc51379c97978.jpg', 3),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_b4ddd09b9f87999eaa18528c12d8c85c.jpg', 4),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/27/2500x2500_50db8581f13d820ac55446d6548236d4.jpg', 5),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_371a07709f0db0185d9eb268abcb7c8c.jpg', 6),
(2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/1000x1000_283431a47cf2e5511b3fab810702885d.jpg', 7),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_c310ad7ee843c59e6d3c496917427212.jpg', 0),
(2031, 'https://img5.su-cdn.com/mall/file/2026/07/07/b5039c5d160bd1ffb02117b6a4600f17.mp4', 1),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_3cf4c2fa8e350ba4ecd559e1eace4c54.jpg', 2),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_98f732b3902bbefeca793168bb4960aa.jpg', 3),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_a80dc2c26f1eb96d59b1d7d18851faf0.jpg', 4),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_0595c8dfe4358b46d616f1bb9d5a168e.jpg', 5),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_91dd2ac82f53a9d8c3fca8ba9636a75a.jpg', 6),
(2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_f661cfdbab29bf2f4ef0aba28435d77f.jpg', 7),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 0),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/18/2500x2500_cc95a988ce827b0e0228b8e9fe77de49.jpg', 1),
(2032, 'https://img5.su-cdn.com/mall/file/2024/12/05/d4fe2ec7c836e3d3a7c94e088d7c3cb9.mp4', 2),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/29/2500x2500_07a0805fb38d3d132e4ff4a77b34433b.jpg', 3),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/30/2500x2500_3e3beb35bb236b2f993059c9d3b3382f.jpg', 4),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/30/2500x2500_ac5f888968c05f7680d20bf543ab2534.jpg', 5),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/30/2500x2500_6655de490b5ecec472ab35d34e34b2dc.jpg', 6),
(2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/23/1000x1000_bd509c01884c2a80d4bb684e889d8813.jpg', 7),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 0),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_1910f16cb61d07583e1601e151d0496a.jpg', 1),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_66f143ff6a1c815373d7d12cd774bfb3.jpg', 2),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_6699e7fe716ba40bac85a7f0db4aef48.jpg', 3),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_43fabbd9d64a2ff3ecf273829bfd6267.jpg', 4),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_effb7316e67217018cd498fb8365d2b3.jpg', 5),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_6a33c702b94f1d227eaaaf93129190eb.jpg', 6),
(2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/780x780_5fce3ee2c61d7029c5a18bab01320b23.jpg', 7),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/09/1600x1600_2cd0ae20465f41f320da1d6b4101fd08.jpg', 0),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_d430badc3648b154aff16bd46769c2ec.jpg', 1),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_8f43c6644f94073802762f5d9babdbdd.jpg', 2),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_edce8c2dd77d172991f57dea48408ea3.jpg', 3),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_dbf76de6c5b7421e1163a498724f57c8.jpg', 4),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/30/2500x2500_b0633d70c8b87f3bae58d5823f17b135.jpg', 5),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/1600x1600_1de609d59a14db11fdef27c8c5bc5253.gif', 6),
(2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_a69ccc36e76d1465c1e18785ce18ab20.jpg', 7),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/aee18aa35e9368a30339efb69488e7db.jpg', 0),
(2035, 'https://img5.su-cdn.com/mall/file/2023/11/10/e5fbb589ec619d19b49abc0b1e2b05a9.mp4', 1),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/5919f0d917510a632268b369b6e61be4.jpg', 2),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/866ed48ec488e69df6aa3d99425d9f42.jpg', 3),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/16cb564ae04ba3f231d963b6353d69bc.jpg', 4),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/08/2500x2500_0a520c233067e690775fe260ecddbb0d.jpg', 5),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/04/19/0f5e47c8b76a7908513f86680c1e7dd9.jpg', 6),
(2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/1000x1000_7c456f29cacbefd24d54d17477874d86.jpg', 7),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_21071fa7feb62ad532c7fe1283741f50.jpg', 0),
(2036, 'https://img5.su-cdn.com/mall/file/2023/07/07/fdbd52e0abf561a6e924de2d209bd3b9.mp4', 1),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_954a9baae79f97d17e0e5c07c479eb10.jpg', 2),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_7b2eb72d5ed66ccab6e1f2a0546993b7.jpg', 3),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_785b0a761a21f0b798c8e51d54a8ce5c.jpg', 4),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_07f4eb0bf76ee4368b84ea4fc0271a32.jpg', 5),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/05/2500x2500_ecfc37e5066e9e96951109cfa7ced453.jpg', 6),
(2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_9cc21cae6bd257919d5e7425b12a3d39.jpg', 7),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 0),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_19540dcdedc9f616d86d44ac529932dd.jpg', 1),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_054327913eb1e43e61e46c254f23ec6c.jpg', 2),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/04/2500x2500_b1696e738886d87fd150577dfd2406e3.jpg', 3),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_b41cd7665f1790e6c1b056320acaa05a.jpg', 4),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/04/2500x2500_17daf53a182888dddca8053abdcd05ea.jpg', 5),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_e47432941879455d1624e1700c6e7d75.jpg', 6),
(2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_46c31ad0c320e1495244adeea11e3731.jpg', 7),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 0),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/14/2500x2500_88b8e0e4f79a8218bbe3efdb5569ad01.jpg', 1),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_a83b1370f0c8aea398e148d427a387e2.jpg', 2),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_3dc826ead2e973cfb35adfdfda08f8f9.jpg', 3),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_fc7663754f4ad8afe540d7eaa9cf1073.jpg', 4),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_6d1fcb0c2068d5cc3194edde7a5c56f6.jpg', 5),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/25/2500x2500_73763ca1c1be8daeb5e763de6d98a4b1.jpg', 6),
(2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/30/2000x2000_1923097e5efb3a82190083a57f9a34e5.jpg', 7),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_fb975dc166c10e23da4ab28783647699.jpg', 0),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_ff8bd635b7477cc03f193b787e703941.jpg', 1),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_c901d16e97b7f9cf3a85de244c7057d0.jpg', 2),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_5f047d620f40e2a711ecdbeeeaafab25.jpg', 3),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/09/c128102b7acdc9d4e8c228dc8f5fdf8c.jpg', 4),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/08/2500x2500_757d3c220458627c2a36c7fb3d768a3c.jpg', 5),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/2500x2500_5c6ad363caaaf14e88b7e3ce55f09082.jpg', 6),
(2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/2500x2500_21e5be40b3bf5d0ae7e458bf0f529a45.jpg', 7),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6b080a113c3048c7ad7e6ac555f79264_.jpg', 0),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fb55f3139a4ea44ab84908cc12aef1622_.jpg', 1),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F228f06a6ff8f47afaad80d91ebff4b1d_.jpg', 2),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F00c42f3100cf482a9e00fe359061d3f8_.jpg', 3),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F1359373eba3b4c39806a7edf2923cead_.jpg', 4),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/01/2500x2500_95344d7699902058358516de858f7c35.jpg', 5),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F0a7741808e35479ab06e23bfdffe4074_.jpg', 6),
(2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/01/2500x2500_d86247d13690b408b8f49fa078df3cb5.jpg', 7),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_e6525b6402e21f66cfb8dabdeb07db40.jpg', 0),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_5ed7a8c451fe656370110852a26c0869.jpg', 1),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_cf1af3c4df5ece3d16891e4ffdea79d0.jpg', 2),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_821b86cfb43691000bdccdc01a6bfd0a.jpg', 3),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_2ea8dd146de9768dd61867c808e019b8.jpg', 4),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/08/2500x2500_44ead8120efb3c4cb2d9b0847d0dfa4a.jpg', 5),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/08/2500x2500_f11f468f055bb84077dc8d128eca5ba7.jpg', 6),
(2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_68b19284cbcd8c8bc414ebaf4c753b1f.jpg', 7);

SET FOREIGN_KEY_CHECKS = 1;
