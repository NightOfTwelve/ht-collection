<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
        <var name="curssp"/>
        <var name="sspCallOut"/>
        <var name="nCause"/>
        <var name="MyCallHook"/>
        <var name="MyCallOutwhoHook"/>
        <var name="OTAFlag"/>

	<!-- ��ȡ��ǰSSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
	      <!-- ����ǰSSP�����curssp������ -->
	      <param name="SSP" expr="curssp"/>
	</object>
	
	<!-- �������� -->
        <object name="MyCallSetup" classid="method://huawei/Call/CallSetup">
            <!-- ���к� -->
            <param name="CLI" expr="'7100'"/>
            <!-- ���к� -->
            <param name="CLD" expr="'7101'"/>
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
                        
                    </if>
                <else/>
                    <!--���н����ɹ�-->
                    <clear namelist="userplaydrv"/>
                    <goto nextitem="userplaydrv" />
                </if>
            </filled>
        </object>   
         

        <!--  ����-->
      	<object name="userplaydrv" classid="method://huawei/InOutPut/VPPlayDrv" cond="false">
		 <!-- ���������ݻ��Ӧ�������� -->
                 <param name="MaxDigit"  value="0"/>
                 <param name="MinDigit"  value="0"/>
                 <param name="PlayType" value="0"/>
		 <param name="PlaySentence" value="20003"/>
		 <param name="PlayObjectSSP" expr="curssp"/>
		 	
		 <filled>	
		        <log>��ʼ���û�����</log> 
	                <if cond="'USER_HOOK'==userplaydrv">
			     <log>�û��һ�</log>
                             <if cond="nCause == curssp">
	                        <log>�������в���</log>
	                        <assign name="OTAFlag" expr="1"/>
	                        <goto nextitem="callOutSspHook" />
	                    <else/>
	                        <log>���нв���</log>
	                        <assign name="OTAFlag" expr="0"/>
	                        <goto nextitem="curSspHook" />
	                    </if>
                        <!-- ֻ�е�MaxDigit=0ʱ�Ŵ��� -->
                        <elseif cond="'PLAY_END'==userplaydrv"/>
			     <log>��������</log>
                             <throw event="exit"/>                
                        <elseif cond="'TIME_OUT'==userplaydrv"/>
               		<!-- ��λ�պų�ʱ -->
			     <log>��ʱ</log>
                             <throw event="exit"/>                 
                        <elseif cond="'ERROR'==userplaydrv"/>
 			     <log>����</log>
                             <throw event="exit"/>     
                        <!-- ֻ�ڲ���OutputInfo ȱʡʱ���и÷���ֵ -->            
                        <elseif cond="'SUCCESS'==userplaydrv"/>
                	     <log>�����ɹ�����</log>
                             <clear namelist="MyMsgProc"/>
                             <goto nextitem="MyMsgProc" />
                        <else/>
                              <log>ժ������</log>
                             <clear namelist="connectcall"/>                   	
                        </if>
                 </filled>
	</object>
	
	<!-- �¼����� -->
        <object name="MyMsgProc" classid="method://huawei/Other/ProcessEvent" cond="false">
            <param name="OutputInfo" expr="nCause"/>
            <filled>
                
                <log>�ȴ�ժ��/�һ�/�����</log>
                <if cond="MyMsgProc=='USER_HOOK_OFF'">
                    <log>��������ժ��</log>
                    <goto nextitem="connectcall" />
                <elseif cond="MyMsgProc=='USER_HOOK'"/>
                    <if cond="nCause == sspCallOut">
                        <log>�������в���</log>
                        <assign name="OTAFlag" expr="1"/>
                        <goto nextitem="callOutSspHook" />
                    <else/>
                        <log>���нв���</log>
                        <assign name="OTAFlag" expr="0"/>
                        <goto nextitem="curSspHook" />
                    </if>
                <else/>
                	<log>����ԭ��</log>
                	<assign name="MyCallHook" expr="0"/>
                        <assign name="MyCallOutwhoHook" expr="0"/>
                	<clear namelist="MyCallOutRel"/>
                </if>
            </filled>
        </object>

        <object name="connectcall" classid="method://huawei/Resource/ConnectCall" cond="false">
		<param name="SspSrc" expr="curssp"/><!--ԴSSP-->
		<param name="SspDes" expr="sspCallOut"/><!--Ŀ��SSP -->
		<param name="ConnectType" value="2"/>
		<filled>
			<log>�ȴ���Դ���ӳɹ�</log>
			<goto nextitem="stoppalaydrv" />
		</filled>
 	</object>
 	
        
	<!-- 0���йһ� -->
	<block name="curSspHook" cond="OTAFlag=='0'">
		<assign name="MyCallHook" expr="4"/>
                <assign name="MyCallOutwhoHook" expr="0"/>
		<goto nextitem="MyCallOutRel"/>
	</block>
	
	<!-- 1���йһ� -->
	<block name="callOutSspHook" cond="OTAFlag=='1'">
		<assign name="MyCallHook" expr="0"/>
                <assign name="MyCallOutwhoHook" expr="4"/>
		<goto nextitem="MyCallRel"/>
	</block>
			
	<!-- �����ͷź������� -->
        <object name="MyCallOutRel" classid="method://huawei/Call/Disconnect" cond="false">
            <param name="Cause" expr="MyCallOutwhoHook"/>
            <param name="SSP" expr="sspCallOut"/>
            <filled>
                <log><value expr="MyCallOutRel"/></log>
                <exit/>
            </filled>
        </object>
        
        <!-- �����ͷŵ�ǰ���� -->
        <object name="MyCallRel" classid="method://huawei/Call/Disconnect" cond="false">
            <param name="Cause" expr="MyCallHook"/>
            <param name="SSP" expr="curssp"/>
            <filled>
                <log><value expr="MyCallRel"/></log>
                <exit/>
            </filled>
        </object>
        
	
	<object name="stoppalaydrv" classid="method://huawei/InOutPut/StopPlayDrv" cond="false">
		<param name="VoiceResource" value="1"/>
		<param name="StopMode" value="0"/>
		
		<filled>
                    <log>ֹͣ����</log>
                    <goto nextitem="connectMyMsgProc" />
                </filled>
	</object>
	<!-- �¼����� -->
        <object name="connectMyMsgProc" classid="method://huawei/Other/ProcessEvent" cond="false">
            <param name="OutputInfo" expr="nCause"/>
            <filled>                
                <log>��ʼͨ��<value expr="connectMyMsgProc"/></log>
                <if cond="MyMsgProc=='USER_HOOK'">             
                    <if cond="nCause == sspCallOut">
                        <log>�������в���</log>
                        <assign name="OTAFlag" expr="1"/>
                        <goto nextitem="callOutSspHook" />
                    <else/>
                        <log>���нв���</log>
                        <assign name="OTAFlag" expr="0"/>
                        <goto nextitem="curSspHook" />
                    </if>
                </if>
            </filled>
        </object>
    </form>
</vxml>
