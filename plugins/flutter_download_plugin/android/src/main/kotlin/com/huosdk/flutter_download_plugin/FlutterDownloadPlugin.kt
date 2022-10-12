package com.huosdk.flutter_download_plugin

import android.content.Context
import android.util.Log
import com.leon.channel.writer.ChannelGenerateUtil
import com.liulishuo.okdownload.DownloadContext
import com.liulishuo.okdownload.DownloadTask
import com.liulishuo.okdownload.OkDownload
import com.liulishuo.okdownload.StatusUtil
import com.liulishuo.okdownload.core.cause.EndCause
import com.liulishuo.okdownload.core.cause.ResumeFailedCause
import com.liulishuo.okdownload.core.listener.DownloadListener3
import com.liulishuo.okdownload.core.listener.assist.Listener1Assist
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File
import java.util.*


class FlutterDownloadPlugin : MethodCallHandler {

    private lateinit var mContext: Context
    private lateinit var flutterChannel: MethodChannel
    private lateinit var builder: DownloadContext.Builder
    private val RETRY_COUNT = 5
    private val TAG_ERROR_RETRY = 0x0011
    private val TAG_ERROR_TIME = 0x0012

    constructor(context: Context, messenger: BinaryMessenger) {
        mContext = context
        flutterChannel = MethodChannel(messenger, CHANNEL)
        flutterChannel.setMethodCallHandler(this)

        //注册广播
        ReceiverManager.getInstance().register(mContext)
    }

    companion object {
        private val CHANNEL = "huosdk/downloader"
        private lateinit var instance: FlutterDownloadPlugin;

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_download_plugin")
            instance = FlutterDownloadPlugin(registrar.context(), registrar.messenger())
            channel.setMethodCallHandler(instance)
        }

        @JvmStatic
        fun getInstance(): FlutterDownloadPlugin {
            return instance
        }
    }


    fun progressCallback(progress: Long, totalLength: Long, gameId: Int) {
        val args = HashMap<String, Any>()
        args["gameId"] = gameId
        args["progress"] = progress
        args["totalLength"] = totalLength
        flutterChannel.invokeMethod("progress", args)
    }

    fun completedCallback(gameId: Int, packageName: String) {
        val args = HashMap<String, Any>()
        args["gameId"] = gameId
        args["packageName"] = packageName
        flutterChannel.invokeMethod("completed", args)
    }

    fun errCallback(gameId: Int) {
        val args = HashMap<String, Any>()
        args["gameId"] = gameId
        flutterChannel.invokeMethod("error", args)
    }

//    fun updateCallBack(){
//        val args = HashMap<String, Any>()
//        flutterChannel.invokeMethod("update", args)
//    }

    //安装成功回调
    fun installSucCallback(packageName: String) {
        val args = HashMap<String, Any>()
        args["packageName"] = packageName
        flutterChannel.invokeMethod("installSuc", args)
    }

    //全局的下载完成回调
    fun globalCompletedCallback(gameId: Int, packageName: String, versionCode: Int, path: String) {
        val args = HashMap<String, Any>()
        args["packageName"] = packageName
        args["gameId"] = gameId
        args["versionCode"] = versionCode
        args["path"] = path
        Log.e("abner", "globalCompletedCallback：$packageName")
        flutterChannel.invokeMethod("globalCompleted", args)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when {
            call.method == "init" -> {
//                OkDownload.with().monitor = GlobalDownloadListener()
//                var maxParallelRunningCount: Int? = call.argument<Int>("maxParallelRunningCount")
//                DownloadDispatcher.setMaxParallelRunningCount(if(maxParallelRunningCount==0) 3 else maxParallelRunningCount)
//                RemitStoreOnSQLite.setRemitToDBDelayMillis(3000)
                builder = DownloadContext.QueueSet()
                        //.setParentPathFile()
                        .setMinIntervalMillisCallbackProcess(150)
                        .commit()

                val context = builder.build()

                //游戏安装广播监听
            }

            //取消所有任务
            call.method == "cancelAll" -> {
                OkDownload.with().downloadDispatcher().cancelAll()
            }

            //暂停filename/url对应的任务
            call.method == "pause" -> {
                val filename = call.argument<String>("fileName")
                val url = call.argument<String>("fileUrl")
                val gameId = call.argument<Int>("gameId")
                var task = getTask(url!!, filename!!)
                task.cancel()
            }

            //移除filename/url对应的任务
            call.method == "remove" -> {
                val filename = call.argument<String>("fileName")
                val url = call.argument<String>("fileUrl")
                val gameId = call.argument<Int>("gameId")
                var task = getTask(url!!, filename!!)
                task.cancel()
                OkDownload.with().breakpointStore().remove(task.id)

            }

            //开始一个任务
            call.method == "start" -> {
                val filename = call.argument<String>("fileName")
                val url = call.argument<String>("fileUrl")
                val gameId = call.argument<Int>("gameId")
                val agent = AppUtils.getAppAgent(mContext)

                println("okDownload Start:$url")
                println("okDownload：Start$filename")

                var task = getTask(url!!, filename!!)
                task.addTag(TAG_ERROR_RETRY, 0)
                task.addTag(TAG_ERROR_TIME, System.currentTimeMillis())
                task.enqueue(object : DownloadListener3() {
                    override fun warn(task: DownloadTask) {
                        Log.e("abner", "warn:")
                    }

                    override fun connected(task: DownloadTask, blockCount: Int, currentOffset: Long, totalLength: Long) {
                        Log.e("abner", "connected:")
                    }

                    override fun retry(task: DownloadTask, cause: ResumeFailedCause) {
                        Log.e("abner", "retry:$cause")
                    }

                    override fun started(task: DownloadTask) {
                        Log.e("abner", "started:")

                    }

                    override fun completed(task: DownloadTask) {
                        Log.e("abner", "completed:" + task.filename)
                        ChannelGenerateUtil.generateChannelApk(task.file!!, agent)   // 使用腾讯VasDolly库打入渠道标识
                        AppUtils.installApk(mContext, task.file!!)
                        var packgaeName = AppUtils.getPackageNameByApkFile(mContext, task.file!!.absolutePath)
                        var versionCode = AppUtils.getVersionCodeFromApkFile(mContext, task.file!!.absolutePath)

                        completedCallback(gameId!!, packgaeName)
                        globalCompletedCallback(gameId!!, packgaeName, versionCode, task.file!!.absolutePath)
                    }

                    override fun error(task: DownloadTask, e: Exception) {
                        Log.e("abner", "error:$e")
                        if (task.getTag(TAG_ERROR_RETRY) as Int > RETRY_COUNT) {
                            errCallback(gameId!!)
                        }
                    }

                    override fun canceled(task: DownloadTask) {
                        Log.e("abner", "canceled:")
                    }

                    override fun progress(task: DownloadTask, currentOffset: Long, totalLength: Long) {
                        progressCallback(currentOffset, totalLength, gameId!!)
                    }

                    override fun taskEnd(task: DownloadTask, cause: EndCause, realCause: java.lang.Exception?, model: Listener1Assist.Listener1Model) {
                        super.taskEnd(task, cause, realCause, model)
                        Log.e("abner", "cause $cause  realCause:$realCause")
                        //失败写入重试机制
                        var count = task.getTag(TAG_ERROR_RETRY) as Int
                        var time = task.getTag(TAG_ERROR_TIME) as Long
                        Log.e("abner", "taskEnd: $time  count: $count")
                        if (cause==EndCause.ERROR&&count<=RETRY_COUNT)
                        {
                            if (System.currentTimeMillis()>(1000*15+time))   //如果上次重试的时间大于15秒  则没有重试过  count重新归零
                            {
                                count=0
                            }
                            task.addTag(TAG_ERROR_TIME, System.currentTimeMillis())
                            task.addTag(TAG_ERROR_RETRY,++count)
                            task.enqueue(this)
                        }

                    }
                })

            }

            //主动获取下载状态信息 通过url 文件名
            call.method == "getStatus" -> {

                val filename = call.argument<String>("fileName")
                val url = call.argument<String>("fileUrl")

                println("getStatus url：$url")
                println("getStatus filename：$filename")
                var status = StatusUtil.getStatus(url!!, getParentFile(mContext).absolutePath, filename)
                println(status)

                when (status) {
                    StatusUtil.Status.UNKNOWN -> result.success(100)
                    StatusUtil.Status.COMPLETED -> result.success(104)
                    StatusUtil.Status.PENDING -> result.success(102)
                    StatusUtil.Status.RUNNING -> result.success(102)
                    StatusUtil.Status.IDLE -> result.success(103)
                    else -> result.success(100)
                }
            }

            //安装
            call.method == "install" -> {
                val filename = call.argument<String>("fileName")
                val url = call.argument<String>("fileUrl")
                val parentFile = getParentFile(mContext)
                AppUtils.installApk(mContext, File(parentFile, filename))
            }

            //打开游戏
            call.method == "open" -> {
                val packageName = call.argument<String>("packageName")
                var isOpen = AppUtils.openAppByPackageName(mContext, packageName)
//                if(!isOpen){
//                    val gameId = call.argument<Int>("gameId")
//                    var task = getTask(url!!, filename!!)
//                    task.cancel()
//                    OkDownload.with().breakpointStore().remove(task.id)
//                    OkDownload.with().breakpointStore().remove()
//                }
                result.success(isOpen)
            }


            //Test
            call.method == "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")

//            call.method == "start" -> {
//                var url = call.argument<String>("url")
//                print("url:$url")
//                result.success("开始下载:$url")
//            }

            call.method == "click" -> {

            }

            else -> result.notImplemented()
        }
    }


    fun getTask(url: String, filename: String): DownloadTask {
        val parentFile = getParentFile(mContext)
        return DownloadTask.Builder(url!!, parentFile)
                .setFilename(filename)
                // the minimal interval millisecond for callback progress
                .setMinIntervalMillisCallbackProcess(16)
                // ignore the same task has already completed in the past.
                .setPassIfAlreadyCompleted(false)
                .build()

    }

    fun getParentFile(context: Context): File {
        val externalSaveDir = context.externalCacheDir
        return externalSaveDir ?: context.cacheDir
    }

}



