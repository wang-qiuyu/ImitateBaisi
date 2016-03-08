//
//  YMTopicCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopicCell.h"
#import "YMTopic.h"
#import "UIImageView+WebCache.h"
#import "YMTopicPictureView.h"
#import "YMVoiceView.h"

@interface YMTopicCell ()
/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 创建时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶按钮*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩按钮*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commentBuuton;
/** 新浪加v*/
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
/** 帖子的文字内容*/
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子中间的内容*/
@property (nonatomic, weak) YMTopicPictureView *pictureView;
/** 声音帖子中间的内容*/
@property (nonatomic, weak) YMVoiceView *voiceView;

@end

@implementation YMTopicCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(YMVoiceView *)voiceView{
    if (_voiceView == nil) {
        YMVoiceView *voiceView = [YMVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(YMTopicPictureView *)pictureView{
    if (_pictureView == nil) {
        YMTopicPictureView *pictureView = [YMTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(void)setTopic:(YMTopic *)topic {
    _topic = topic;
    //新浪加V
    self.sina_vImageView.hidden = !topic.sina_v;
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置名字
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentBuuton count:topic.comment placeholder:@"评论"];
    
    //根据模型类型（帖子类型）添加到对应的内容cell中间
    if (topic.type == YMTopicTypePicture) { //图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }  else if (topic.type == YMTopicTypeVoice) {
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
    }
}

-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame {
    
    frame.origin.x = YMTopicCellMargin;
    frame.size.width -= 2 * YMTopicCellMargin;
    frame.size.height -= YMTopicCellMargin;
    frame.origin.y += YMTopicCellMargin;
    
    [super setFrame:frame];
}

@end
