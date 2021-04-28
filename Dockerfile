# FROM *** で使用するベースイメージを指定
FROM mcr.microsoft.com/windows/servercore/iis

# ホストの C:\docker\build\iisを コンテナの C:\ 配下にコピーする
COPY iis /inetpub

#APS.NET4.7インストール(関連ファイル含む)
RUN powershell  Install-WindowsFeature -Name Web-Asp-Net45 -IncludeManagementTools

#アプリケーションプール myiisの設定
#「.NET Framework バージョン」を「ｖ4.0」に設定
#「32 ビットアプリケーションの有効化」を「True」に設定
#「プロセスモデル」の「ID」を「Network Service」に設定
RUN C:\Windows\System32\inetsrv\appcmd.exe add apppool /name:myiis /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated /enable32BitAppOnWin64:true /processModel.identityType:NetworkService

# コンテナ 起動時に実行されるコマンド。ServiceMonitor.exe が w3svcのサービス(IISのサービス)状態を監視。 
#w3svcのサービスが停止すればコンテナも停止する。
CMD ["C:\\ServiceMonitor.exe", "w3svc"]