<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<!-- ���ͱ�� -->
		<object name="SendMemo" classid="method://huawei/Other/SendMemo">
			<!-- ���ձ�����ϯ���� -->
			<param name="AgentNO" expr="104"/>
			<param name="PackInfo" expr="'abcd��ӭ,����123'"/>
			
			<!-- 
				ʹ��PackInfoʱ���Բ���дExtraDataLen
			 <param name="ExtraDataLen" expr="10"/>-->
			 <filled>
			 	<log>���ͱ�ǩ<value expr="SendMemo"/></log>
			 </filled>
		</object>
	</form>
</vxml>
