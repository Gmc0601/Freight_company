//
//  CCUrl.h
//  CarSticker
//
//  Created by cc on 2017/3/21.
//  Copyright © 2017年 cc. All rights reserved.
//

#ifndef CCUrl_h
#define CCUrl_h
/*
 接口文档
 */
#define TokenKey @"1e56c95504a9a846e4c7043704a20f25"

#define UDID     0

/*****************************测试开关*******************************/

#define HHTest   1      // 1 测试  0 上传

/*****************************测试开关*******************************/

#if HHTest
//http://139.224.70.219/jyb/index.php?
#define    BaseApi       @"http://47.97.114.204/index.php?s="

#else

#define    BaseApi      @"http://47.97.114.204/index.php?s="

#endif



#endif /* CCUrl_h */
