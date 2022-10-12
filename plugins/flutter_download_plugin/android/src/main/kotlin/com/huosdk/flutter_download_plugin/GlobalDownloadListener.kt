package com.huosdk.flutter_download_plugin

import com.liulishuo.okdownload.DownloadMonitor
import com.liulishuo.okdownload.DownloadTask
import com.liulishuo.okdownload.core.breakpoint.BreakpointInfo
import com.liulishuo.okdownload.core.cause.EndCause
import com.liulishuo.okdownload.core.cause.ResumeFailedCause
import java.lang.Exception

class GlobalDownloadListener: DownloadMonitor {
    override fun taskDownloadFromBeginning(task: DownloadTask, info: BreakpointInfo, cause: ResumeFailedCause?) {
    }

    override fun taskDownloadFromBreakpoint(task: DownloadTask, info: BreakpointInfo) {
    }

    override fun taskStart(task: DownloadTask?) {
    }

    override fun taskEnd(task: DownloadTask?, cause: EndCause?, realCause: Exception?) {
    }
}