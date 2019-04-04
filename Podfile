#Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'ruyiruyiios' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for ruyiruyiios

  pod 'MBProgressHUD'
  pod 'AFNetworking'
  pod 'SDWebImage'
  pod 'MJRefresh'
  pod 'Masonry'
  pod 'FMDB'
  pod 'SDCycleScrollView'
  pod 'GTMBase64'
  pod 'SVProgressHUD'
  pod 'Bugly'
  pod 'MOFSPickerManager'

  #解决scrollView 手势滑动返回冲突
  pod 'TZScrollViewPopGesture'
  #侧滑返回
  pod 'FDFullscreenPopGesture'
  # 主模块(必须)
  pod 'mob_sharesdk'
 
  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'mob_sharesdk/ShareSDKUI'
   
  # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
  #(微信sdk不带支付的命令）
  # pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'   
  #（微信sdk带支付的命令，和上面不带支付的不能共存，只能选择一个）
  pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull' 
end
