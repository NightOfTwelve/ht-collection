<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="transToQueue">
	
		<object name="ROUT" classid="method://huawei/Other/RequestRouting" >
		
			<!-- ·������ 1���պ���Ϣ��2���û���������3����ϯ���š�4���˹�̨���� -->
			<param name="RoutingType" value="2"/>
			
			<!-- ·����Ϣ 1�����̽�����򱻽к��롢2�����ܶ������ƣ�������̨�鿴����3����ϯ�Ĺ��š�4��·����ϢΪ�գ�����������̨������������������ -->
			<param name="RoutingInfo" value="voice1"/>
			
			<!-- WaitReturn�Ƿ�ȴ����أ�0��ʾ���ȴ����أ�1��ʾ�ȴ����أ�10��ʾ·��ת��IVR -->
			<param name="WaitReturn" value="1"/>
			
			<!-- QueueFlag�Ƿ��Ŷӱ�ǣ�0��ʾ���Ŷӣ�1��ʾ�Ŷ� -->
			<param name="QueueFlag" value="1"/>
			
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
