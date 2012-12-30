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
		
		<!-- �������� -->
        <object name="MyCallSetup" classid="method://huawei/Call/CallSetup">
            <!-- ���к� -->
            <param name="CLI" expr="'6669001'"/>
            <!-- ���к� -->
            <param name="CLD" expr="'010086'"/>
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
                        <clear namelist="MyCallOutRel MyCallRel"/>
                    <else/>
                        <log>���нв���</log>
                        <clear namelist="MyCallOutRel MyCallRel"/>
                    </if>
                <else/>
                	<log>����ԭ��</log>
                	<clear namelist="MyCallOutRel MyCallRel"/>
                </if>
            </filled>
        </object>


		<!-- ��ȡ����ԭ�� -->
        <object name="MyCheckRel" classid="method://huawei/Call/GetDisconnectCause" expr="true">
            <param name="Cause" expr="nCause"/>
            <filled>
                <log>�������в���, ��Ҫ������ԭ��</log>
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
		
		<!-- �����ͷź������� -->
        <object name="MyCallOutRel" classid="method://huawei/Call/Disconnect" expr="true">
            <param name="Cause" expr="0"/>
            <param name="SSP" expr="sspCallOut"/>
            <filled>
                <log><value expr="MyCallOutRel"/></log>
            </filled>
        </object>
        
        <!-- �����ͷŵ�ǰ���� -->
        <object name="MyCallRel" classid="method://huawei/Call/Disconnect" expr="true">
            <param name="Cause" expr="0"/>
            <param name="SSP" expr="curssp"/>
            <filled>
                <log><value expr="MyCallRel"/></log>
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
