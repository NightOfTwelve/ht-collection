<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<var name="param" expr="Object()"/>
		<block>
			<assign name="param.type" expr="'String'"/>
			<assign name="param.value" expr="'����123abc'"/>
			<assign name="param.size" expr="10"/>
		</block> 
		<var name="nPackLen" expr="0"/>
		<object name="Pack" classid="method://huawei/Other/Pack">
			<param name="PackLen" expr="nPackLen"/>
			<param name="paramname" expr="param"/>
		</object>
		<!-- ���ͱ�� -->
		<object name="SendMemo" classid="method://huawei/Other/SendMemo">
			<!-- ���ձ�����ϯ���� -->
			<param name="AgentNO" expr="104"/>
			 <param name="ExtraDataLen" expr="10"/>
			 <filled>
			 	<log>���ͱ�ǩ<value expr="SendMemo"/></log>
			 </filled>
		</object>
	</form>
</vxml>
