<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>	
		<!-- ��������Ϊ����ʱ����������д����̷��������ʹ��y:/1.wav �� ����ʹ��y:\1.wav (��ȡΪ����)�� -->
		<var name="para"/>
		<block>
			<!--Ӧ��ʹ��y:/1.wav,��������̷��򲻻�������-->
			<assign name="para" expr="'y:/1.wav'"/>
			<value expr="para"/>
		</block>
	</form>
</vxml>