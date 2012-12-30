<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
        <var name="curssp"/>
        <var name="sspCallOut"/>
        <var name="nCause"/>

		<!-- ��ȡ��ǰSSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<!-- ����ǰSSP�����curssp������ -->
			<param name="SSP" expr="curssp"/>
		</object>
		
		<!-- ��������IE ��չ���� -->
        <object name="MySetIE" classid="method://huawei/CallExtend/operateieinfo">
        	<!-- ������ʽ��0��ʾȥ������Ϣ��1��ʾ���ú�����Ϣ -->
            <param name="OperateType" expr="0"/>
            <!-- ��Ϣ���� 1��setup 3��alert 4��notify 5��answer 7��offhook 8: Disconnect 32��redirct -->
            <param name="MsgType" expr="1"/>
            <!-- IE�����ƣ�135��ʾ��ⱻ��״̬ -->
            <param name="IeName" expr="135"/>
            <!-- ��Ϣ����ID -->
            <param name="InfoName" expr="0"/>
            <!-- IE ��Ϣֵ -->
            <param name="InfoValue" expr="1"/>
            <filled>
                <clear namelist="MyCallSetup"/>
            </filled>
        </object>

		<!-- �������� -->
        <object name="MyCallSetup" classid="method://huawei/Call/CallSetup" expr="true">
            <!-- ���к� -->
            <param name="CLI" expr="'6669001'"/>
            <!-- ���к� -->
            <param name="CLD" expr="'7102'"/>
            <!-- �������� ��0��ʾ��ͨ���� -->
            <param name="CF" expr="0"/>
            <!-- ������������ظôκ��е�SSP -->
            <param name="SSP" expr="sspCallOut"/>
            <!-- �������������ԭ���� -->
            <param name="Cause" expr="nCause"/>
            <filled>
                <if cond="MyCallSetup!='SUCCESS'">
                    <!--���н���ʧ�ܣ�ֱ�ӻ�ȡ����ԭ����-->
                    <if cond="nCause==255">
                        <log>���в���</log>
                        <throw event="exit"/>
                    <else/>
                        <clear namelist="MyCheckRel"/>
                    </if>
                <else/>
                    <!--���н����ɹ�-->
                    <clear namelist="MyMsgProc"/>
                </if>
            </filled>
        </object>   
         

		<!-- �¼����� -->
        <object name="MyMsgProc" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo" expr="nCause"/>
            <filled>
                
                <log>�ȴ�ժ��/�һ�/�����</log>
                <if cond="MyMsgProc=='USER_HOOK_OFF'">
                    <log>��������ժ��������combine</log>
                    <clear namelist="combine MyMsgProc2"/>
                <elseif cond="MyMsgProc=='USER_HOOK'"/>
                    <if cond="nCause == sspCallOut">
                        <log>�������в���</log>
                        <clear namelist="MyCheckRel"/>
                    <else/>
                        <log>���нв���</log>
                    </if>
                <elseif cond="MyMsgProc=='RECEIVE_DETECT_RES'"/>
                    <if cond="nCause==1"><!-- �û����� -->
                        <clear namelist="MyMsgProc"/><!-- �����ȴ�����ժ�� -->
                    <elseif cond="nCause==2"/><!-- �û�æ -->
                        
                    <elseif cond="nCause==3"/> <!-- NO_RESOURCE -->
                       
                    <elseif cond="nCause==4"/><!-- CALL_DIVERSION -->
                        
                    <elseif cond="nCause==5"/><!-- CALL_WAITING -->
                        
                    <elseif cond="nCause==6"/><!-- DEFLECTION_BUSY -->
                        
                    <elseif cond="nCause==7"/><!-- DEFLECTION_NO_RESPOND -->
                        
                    <elseif cond="nCause==8"/><!-- DEFLECTION_UNCONDICTION -->
                        
                    <elseif cond="nCause==9"/><!-- DET_CALL_SUPER_DONT_DISTURB -->
                        
                    <elseif cond="nCause==10"/> <!-- DET_CALL_DEFLECTION -->
                       
                    <elseif cond="nCause==11"/><!-- DET_DEFLECTION_IMMEDIATE_RESPONSE -->
                        
                    <elseif cond="nCause==12"/> <!-- DET_MOBILE_SUBSCRIBER_NOT_REACHABLE -->
                       
                    <elseif cond="nCause==13"/><!-- DET_CALLED_DTE_OUT_OF_ORDER -->
                        
                    <elseif cond="nCause==14"/><!-- DET_CALL_FORWARDING_BY_THE_CALLED_DTE -->
                        
                    <elseif cond="nCause==15"/><!-- DET_CALLED_CT -->
                        
                    <elseif cond="nCause==16"/><!-- DET_RESERVE1 -->
                        
                    <elseif cond="nCause==17"/> <!-- DET_RESERVE2 -->
                      
                    <elseif cond="nCause==18"/><!-- DET_ANNOUNCE_SIG -->
                        
                    <elseif cond="nCause==129"/> <!-- UNALLOC_CODE -->
                       
                    <elseif cond="nCause==132"/><!-- SEND_PRIVATE_TONE -->
                        
                    <elseif cond="nCause==145"/><!-- �û�æ -->
                        
                    <elseif cond="nCause==146"/> <!-- �û�δ��Ӧ -->
                       
                    <elseif cond="nCause==147"/> <!-- �û�δӦ�� -->
                       
                    <elseif cond="nCause==149"/><!-- ���о���-->
                        
                    <elseif cond="nCause==150"/><!-- ����ı� -->
                        
                    <elseif cond="nCause==155"/> <!-- Ŀ�ĵز��ɴ� -->
                       
                    <elseif cond="nCause==160"/><!-- INTESS_OC_MD_MUSIC -->
                        
                    <elseif cond="nCause==161"/>
                        <!-- INTESS_OC_AMD_HUMAN -->
                    <elseif cond="nCause==162"/>
                        <!-- INTESS_OC_AMD_MACHINE -->
                    <elseif cond="nCause==180"/>
                        <!-- INTESS_OC_TD_RINGBACK -->
                    <elseif cond="nCause==181"/>
                        <!-- INTESS_OC_TD_BUSY -->
                    <elseif cond="nCause==182"/>
                        <!-- INTESS_OC_TD_SIT -->
                    <elseif cond="nCause==184"/>
                        <!-- INTESS_OC_TD_MODEM -->
                    <elseif cond="nCause==185"/>
                        <!-- INTESS_OC_TD_FAX -->
                    <elseif cond="nCause==186"/>
                        <!-- INTESS_OC_TD_MODEMORFAX -->
                    <elseif cond="nCause==187"/>
                        <!-- INTESS_OC_TD_TONE_UNDEFINE -->
                    <elseif cond="nCause==190"/>
                        <!-- INTESS_OC_TD_TP_ANS1 -->
                    <elseif cond="nCause==191"/>
                        <!-- INTESS_OC_TD_TP_ANS2 -->
                    <elseif cond="nCause==192"/>
                        <!-- INTESS_OC_TD_TP_ANS3 -->
                    <elseif cond="nCause==193"/>
                        <!-- INTESS_OC_TD_TP_ANS4 -->
                    <elseif cond="nCause==194"/>
                        <!-- INTESS_OC_TD_TP_ANS5 -->
                    <elseif cond="nCause==195"/>
                        <!-- INTESS_OC_TD_TP_EDT -->
                    <elseif cond="nCause==196"/>
                        <!-- INTESS_OC_TD_TP_FSK -->
                    <elseif cond="nCause==197"/>
                        <!-- INTESS_OC_TD_TP_DTMF -->
                    <elseif cond="nCause==253"/><!-- ��֪���Ļ����� -->
                        <clear namelist="MyMsgProc"/><!-- �����ȴ�����ժ�� -->
                    <elseif cond="nCause==254"/><!-- ���ź���������ʱ�����յ��û���Ӧ����Ϣ -->
                        <clear namelist="MyMsgProc"/><!-- �����ȴ�����ժ�� -->
                    <elseif cond="nCause==255"/>
                        <!-- BUTT_TONE -->
                    <else/>
                        <!-- unknown -->
                    </if> 
                    <!-- impossible -->
                </if>
            </filled>
        </object>


		<!-- ��ȡ����ԭ�� -->
        <object name="MyCheckRel" classid="method://huawei/Call/GetDisconnectCause" expr="true">
            <param name="Cause" expr="nCause"/>
            <filled>
                <log>�������в���, ��Ҫ������ԭ��</log>
                 <log>����ԭ���룺<value expr="nCause"/></log>
                <if cond="nCause==0"><!--�����������-->
                 
                <elseif cond="nCause==1"/> <!--��Դ��ռ��-->
                   
                <elseif cond="nCause==2"/><!--��ʱ-->
                    
                <elseif cond="nCause==3"/><!--����ʧ��-->
                    
                <elseif cond="nCause==4"/><!--�պ�-->                    
            
                <elseif cond="nCause==8"/><!--�û���Ӧ��-->
                    
                <elseif cond="nCause==9"/><!--�û��ܾ�-->
                    
                <elseif cond="nCause==10"/><!--SP_Call_Absent-->
                    
                <elseif cond="nCause==47"/><!--�û�æ-->
                    
                <elseif cond="nCause==48"/>
                    <!--SP_CpConf_Fault-->
                <elseif cond="nCause==49"/>
                    <!--SP_Intess_Error-->
                <elseif cond="nCause==50"/>
                    <!--SP_NO_OUT_BOUND_CALL_DETECT_RESOURCE-->
                <else/>
                    <!-- unknown cause -->
                </if>
            </filled>
        </object>
		
		<!-- �����ͷź��� -->
        <object name="MyCallOutRel" classid="method://huawei/Call/Disconnect" expr="true">
            <param name="Cause" expr="0"/>
            <param name="SSP" expr="sspCallOut"/>
            <filled>
                <log><value expr="MyCallOutRel"/></log>
            </filled>
        </object>
                <object name="combine" classid="method://huawei/Resource/ConnectCall" expr="true">
        	<param name="SspSrc" expr="curssp"/>
        	<param name="SspDes" expr="sspCallOut"/>
        	<param name="ConnectType" expr="2"/>
        </object>
        
         <object name="MyMsgProc2" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo" expr="nCause"/>
            <filled>
                <if cond="MyMsgProc=='USER_HOOK'">
                	<exit/>
				</if>
            </filled>
        </object>
        <!-- �������ӣ���SSP1��SSP2������������ 
        <object name="combine" classid="method://huawei/Call/Combine" expr="true">
			<param name="SSP1" expr="sspCallOut"/>
			<param name="SSP2" expr="curssp"/>
		</object>
		-->
    </form>
</vxml>
