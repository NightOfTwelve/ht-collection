<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<!-- ����Ӧ�� -->
		<object name="myAnswer" classid="method://huawei/Call/Answer">
			<param name="ChargeIndicator" value="0"/>
			<filled>
				<if cond="myAnswer != 'SUCCESS'">
					<throw event="exit"/>
				</if>
			</filled>
		</object>
		<!-- �����պ� -->
		<var name="outputinfo"/>
		<object name="vpplaydrv" classid="method://huawei/InOutPut/VPPlayDrv">
			<!-- ���������ݻ��Ӧ�������� -->
            <param name="MaxDigit"  value="3"/>
            <param name="MinDigit"  value="2"/>     
            <param name="InterTime" value="5"/>
            <param name="FirstTime" value="20"/>
            <param name="EndDigit" value="#"/>
            <param name="CancelDigit" value="*"/>
			<param name="PlaySentence" value="y:\wait.wav"/>
			<!-- �ռ������û��������Ϣ����ֵ -->
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<log>������ĺ����ǣ�<value expr="outputinfo"/></log>
				<if cond="'USER_HOOK'==vpplaydrv">
					<log>�û��һ�</log>
                   <throw event="exit"/>
               <elseif cond="'USER_DIALING'==vpplaydrv"/>
               		<!-- ���ź�λ���պų�ʱ
               			 ���λ���պų�ʱ�����յĺ�С����С�պ�λ�������պŽ��Ϊ��
               			 ����Ѿ����ڵ�����С�պ�λ�������պŽ��ȡ�Ѿ��յĺš�
               		 -->
               		<log>�պŷ���</log>
                   <throw event="exit"/>
                   <!-- ֻ�е�MaxDigit=0ʱ�Ŵ��� -->
               <elseif cond="'PLAY_END'==vpplaydrv"/>
					<log>��������</log>
                   <throw event="exit"/>                
               <elseif cond="'TIME_OUT'==vpplaydrv"/>
               		<!-- ��λ�պų�ʱ -->
					<log>��ʱ</log>
                   <throw event="exit"/>                 
                <elseif cond="'ERROR'==vpplaydrv"/>
 					<log>����</log>
                   <throw event="exit"/>     
                <!-- ֻ�ڲ���OutputInfo ȱʡʱ���и÷���ֵ -->            
                <elseif cond="'SUCCESS'==vpplaydrv"/>
                	
					<log>������Ϣ�ɹ�</log>
                   <throw event="exit"/>                   	
               </if>
			</filled>
		</object>
	</form>
		
	
</vxml>