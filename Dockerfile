# FROM *** �Ŏg�p����x�[�X�C���[�W���w��
FROM mcr.microsoft.com/windows/servercore/iis

# �z�X�g�� C:\docker\build\iis�� �R���e�i�� C:\ �z���ɃR�s�[����
COPY iis /inetpub

#APS.NET4.7�C���X�g�[��(�֘A�t�@�C���܂�)
RUN powershell  Install-WindowsFeature -Name Web-Asp-Net45 -IncludeManagementTools

#�A�v���P�[�V�����v�[�� myiis�̐ݒ�
#�u.NET Framework �o�[�W�����v���u��4.0�v�ɐݒ�
#�u32 �r�b�g�A�v���P�[�V�����̗L�����v���uTrue�v�ɐݒ�
#�u�v���Z�X���f���v�́uID�v���uNetwork Service�v�ɐݒ�
RUN C:\Windows\System32\inetsrv\appcmd.exe add apppool /name:myiis /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated /enable32BitAppOnWin64:true /processModel.identityType:NetworkService

# �R���e�i �N�����Ɏ��s�����R�}���h�BServiceMonitor.exe �� w3svc�̃T�[�r�X(IIS�̃T�[�r�X)��Ԃ��Ď��B 
#w3svc�̃T�[�r�X����~����΃R���e�i����~����B
CMD ["C:\\ServiceMonitor.exe", "w3svc"]