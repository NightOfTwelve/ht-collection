
<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	
	<form id="packData">
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
		
		<!-- ȡ�˹�̨���� -->
		<object name="getData" classid="method://huawei/CallExtend/OperatorData">
			<!-- ������ʽ,0��ʾȡ�˹�̨����,1��ʾ�����˹�̨���� -->
			<param name="OperateType" value="1"/>
			<!-- ��ʾ�˹�̨����������Ч���ݵĳ��ȡ���󳤶Ȳ��ܳ���1024 ���ֽڡ� -->
			<param name="DataLen" value="10"/>
			<!-- ����������˹�̨���ݣ��ò���Ϊ�����������ʾ���ݸ��˹�̨�����ݣ�
				 �����ȡ�˹�̨���ݣ��ò���Ϊ�����������ʾ���˹�̨���յ������ݡ�
				 ȱʡ��ʾʹ��ϵͳ�������и�����Ϣ�� -->
			<!--<param name="DataInfo" expr="dataInfo"/>  -->
			<filled>
				<log>��ȡ����<value expr="getData"/></log>
				<goto next="#transToQueue"/>
			</filled>
		</object>
	</form>

	<form id="transToQueue">
	
		<object name="ROUT" classid="method://huawei/Other/RequestRouting">
		
			<!-- ·������ 1���պ���Ϣ��2���û���������3����ϯ���š�4���˹�̨���� -->
			<param name="RoutingType" value="3"/>
			
			<!-- ·����Ϣ 1�����̽�����򱻽к��롢2�����ܶ������ƣ�������̨�鿴����3����ϯ�Ĺ��š�4��·����ϢΪ�գ�����������̨������������������ -->
			<param name="RoutingInfo" value="104"/>
			
			<!-- WaitReturn�Ƿ�ȴ����أ�0��ʾ���ȴ����أ�1��ʾ�ȴ����أ�10��ʾ·��ת��IVR -->
			<param name="WaitReturn" value="0"/>
			
			<!-- QueueFlag�Ƿ��Ŷӱ�ǣ�0��ʾ���Ŷӣ�1��ʾ�Ŷ� -->
			<param name="QueueFlag" value="0"/>
			
			<filled>
				<if cond="ROUT=='OPR_SUCCESS'">
					<clear namelist="SuccessResult"/>
				</if>
			</filled>
		</object>
		<block name="SuccessResult" expr="true">
			<exit/>
		</block>
	</form>
</vxml>

