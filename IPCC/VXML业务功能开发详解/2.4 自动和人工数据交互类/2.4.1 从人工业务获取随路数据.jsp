<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="getDataFrmAgent">
		
		<!-- ȡ�˹�̨���� -->
		<object name="getData" classid="method://huawei/CallExtend/OperatorData">
			<!-- ������ʽ,0��ʾȡ�˹�̨����,1��ʾ�����˹�̨���� -->
			<param name="OperateType" value="0"/>
			<!-- ��ʾ�˹�̨����������Ч���ݵĳ��ȡ���󳤶Ȳ��ܳ���1024 ���ֽڡ� -->
			<param name="DataLen" value="100"/>
			<!-- ����������˹�̨���ݣ��ò���Ϊ�����������ʾ���ݸ��˹�̨�����ݣ�
				 �����ȡ�˹�̨���ݣ��ò���Ϊ�����������ʾ���˹�̨���յ������ݡ�
				 ȱʡ��ʾʹ��ϵͳ�������и�����Ϣ�� -->
			<!--<param name="DataInfo" expr="dataInfo"/>  -->
			<filled>
				<log>��ȡ����<value expr="getData"/></log>
			</filled>
		</object>
		<var name="param" expr="Object()"/>
		<block >
			<assign name="param.type" expr="'String'" />
			<assign name="param.size" expr="100"/>
		</block> 
		<var name="nPackLen" expr="0"/>
		<!--���-->
		<object name="Unpack" classid="method://huawei/Other/Unpack">
			<param name="PackLen" expr="nPackLen"/>
			<param name="paramname" expr="param"/>
		</object>
		
		<block >
			<log>�˹�̨��ȡ��������:<value expr="param.value"/></log>
		</block>
	</form>
</vxml>