# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in D:\environment\android-sdk-windows/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
-applymapping jar/mapping.txt
# keep annotated by NotProguard 保护使用NotProguard不混淆
# 特别注意内部类会被混淆掉

-keep class com.game.sdk.**{*;}
-keep class com.game.sdk.util.NotProguard
-keep @com.game.sdk.util.NotProguard class * {*;}
-keepclasseswithmembers class * {
    @com.game.sdk.util.NotProguard <methods>;
}
#
-keepclasseswithmembers class * {
    @com.game.sdk.util.NotProguard <fields>;
}
#
-keepclasseswithmembers class * {
    @com.game.sdk.util.NotProguard <init>(...);
}