//
//  upLoadIDCardViewController.m
//  sanxi
//
//  Created by liangang on 2017/6/6.
//  Copyright © 2017年 liangang. All rights reserved.
//

#import "upLoadIDCardViewController.h"
#import "YTKBatchRequest.h"
@interface upLoadIDCardViewController ()<UIActionSheetDelegate>
{
    DBCameraViewController *frontCameraController;
    DBCameraViewController *backCameraControllerl;
    DBCameraViewController *menWithIDCardCameraController;
    NSInteger selectIndex;
    UIImage *frontImage;
    UIImage *backImage;
    UIImage *menWithIDCardImage;

}
@end

@implementation upLoadIDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传资料";
    [self.longTermImageView setHighlighted:YES];
    [self.frontImageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"PositiveIdUrl"]] placeholderImage:[UIImage imageNamed:@"IDfront"]];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"OppsiteIdUrl"]] placeholderImage:[UIImage imageNamed:@"IDBack"]];
    [self.menWithIDImageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"HandleCardIdUrl"]] placeholderImage:[UIImage imageNamed:@"menWithIDCard"]];
    if ([self.dic[@"Type"] integerValue]==5) {
        [self.longTermImageView setHighlighted:YES];
        [self.unLongTermImageView setHighlighted:NO];
    }
    else
    {
        [self.longTermImageView setHighlighted:NO];
        [self.unLongTermImageView setHighlighted:YES];
    }
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)CameraBtnClick:(id)sender {
//    UIActionSheet *actionSheest = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册",nil];
//    [actionSheest showInView:self.view];
    frontCameraController = [DBCameraViewController initWithDelegate:self];
    selectIndex = 1;
    [frontCameraController setUseCameraSegue:NO];
    [frontCameraController setLibraryMaxImageSize:320]; //You can set a value for the maximum output resolution for the image selected from the Library
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:frontCameraController];
    [container setFullScreenMode];
    //    DemoNavigationController *nav = [[DemoNavigationController alloc] initWithRootViewController:container];
    [self presentViewController:container    animated:YES completion:nil];
    
    
}
- (IBAction)backCameraBtnClick:(id)sender {
    backCameraControllerl = [DBCameraViewController initWithDelegate:self];
    selectIndex = 2;
    [backCameraControllerl setUseCameraSegue:NO];
    [backCameraControllerl setLibraryMaxImageSize:320]; //You can set a value for the maximum output resolution for the image selected from the Library
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:backCameraControllerl];
    [container setFullScreenMode];
    //    DemoNavigationController *nav = [[DemoNavigationController alloc] initWithRootViewController:container];
    [self presentViewController:container    animated:YES completion:nil];
    
}
- (IBAction)menWithIDBtnClick:(id)sender {
    menWithIDCardCameraController = [DBCameraViewController initWithDelegate:self];
    selectIndex = 3;
    [menWithIDCardCameraController setUseCameraSegue:NO];
    [menWithIDCardCameraController setLibraryMaxImageSize:320]; //You can set a value for the maximum output resolution for the image selected from the Library
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:menWithIDCardCameraController];
    [container setFullScreenMode];
    //    DemoNavigationController *nav = [[DemoNavigationController alloc] initWithRootViewController:container];
    [self presentViewController:container    animated:YES completion:nil];

}
//- (IBAction)menWithIDBtnClick:(id)sender {
    

//
//}
- (void) dismissCamera:(id)cameraViewController{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
    
    if (selectIndex ==1) {
//        [self.frontBtn setTitle:@"" forState:UIControlStateNormal];
//        [self.frontBtn setBackgroundImage:image forState:UIControlStateNormal ];
//        frontImage = image;
//        [self.frontBg setBackgroundColor:[UIColor colorWithPatternImage:image]];
        [self.frontImageView setImage:image];
        frontImage = image;
        
    }
    if (selectIndex ==2) {
//        [self.backBtn setTitle:@"" forState:UIControlStateNormal];
//        [self.backBtn   setBackgroundImage:image forState:UIControlStateNormal ];
//        backImage = image;
//        [self.backBg setBackgroundColor:[UIColor colorWithPatternImage:image]];
        [self.backImageView setImage:image];
        backImage = image;
    }
    if (selectIndex==3) {
        [self.menWithIDImageView setImage:image];
        menWithIDCardImage = image;
    }
    //    if (image.size.width>1000) {
    //        UIImage *newImage = [extendMethod imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width/7, image.size.height/7)];
    //        [imageView setImage:newImage];
    //    }
    //    else
    //    {
    //        [imageView setImage:image];
    //    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)longTermBtnClick:(id)sender {
    [self.longTermImageView setHighlighted:YES];
    [self.unLongTermImageView    setHighlighted:NO];
}
- (IBAction)unLongTermBtnClick:(id)sender {
    [self.longTermImageView setHighlighted:NO];
    [self.unLongTermImageView    setHighlighted:YES];
}
- (IBAction)upLoadAction:(id)sender {
    if (!frontImage) {
        [extendMethod showMessage:@"请拍摄身份证正面的照片"];
        return;
    }
    if (!backImage) {
        [extendMethod showMessage:@"请拍摄身份证反面的照片"];
        return;
    }
    if (!menWithIDCardImage) {
        [extendMethod showMessage:@"请拍摄本人与身份证合影照"];
        return;
    }
    uploaderPicApi *api1 = [[uploaderPicApi alloc]init];
    api1.image = frontImage;
    uploaderPicApi *api2 = [[uploaderPicApi alloc]init];
    api2.image = backImage;
    uploaderPicApi *api3 = [[uploaderPicApi alloc]init];
    api3.image = menWithIDCardImage;
    
    YTKBatchRequest *requsts = [[YTKBatchRequest alloc]initWithRequestArray:@[api1,api2,api3]];
    [requsts     startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        certificationApi *api = [[certificationApi alloc]init];
       
        [batchRequest.requestArray enumerateObjectsUsingBlock:^(uploaderPicApi *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",obj.responseString);
            switch (idx) {
                case 0:
                    api.PositiveId = [obj.responseJSONObject[@"pictureId"] integerValue];
                    break;
                case 1:
                    api.OppsiteId = [obj.responseJSONObject[@"pictureId"] integerValue];
                    break;
                case 2:
                    api.HandleCardId = [obj.responseJSONObject[@"pictureId"] integerValue];
                    break;
                    
                default:
                    break;
            }
        }];
        if (self.longTermImageView.isHighlighted) {
            api.Type= 5;
        }
        else
            api.Type = 0;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            NSLog(@"%@",request.responseString);
            if ([request.responseJSONObject[@"result"] integerValue]==1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
             NSLog(@"%@",request.responseString);
        }];
    } failure:^(YTKBatchRequest *batchRequest) {
        
    }];
//    uploaderPicApi *api = [[uploaderPicApi alloc]init];
//    api.image = frontImage;
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"%@",request.responseString);
//    } failure:^(__kindof YTKBaseRequest *request) {
//         NSLog(@"%@",request.responseString);
//    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
