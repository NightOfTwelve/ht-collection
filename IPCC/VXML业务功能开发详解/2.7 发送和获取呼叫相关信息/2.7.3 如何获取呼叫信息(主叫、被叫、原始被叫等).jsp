<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
    	<!-- ���к� -->
        <var name="callerNo" expr="session.telephone.ani"/>
        <!-- ���к�(���̽�����)-->
		<var name="calledNo" expr="session.telephone.dnis"/>
		<!-- ԭʼ�����д����� -->
		<var name="orgCalledNo" expr="session.telephone.odnis"/>
		
		
		<block>
			<log>���к�:<value expr="callerNo"/></log>
			<log>���к�(���̽�����):<value expr="calledNo"/></log>
			<log>ԭʼ���к�:<value expr="orgCalledNo"/></log>
		</block>
		<var name="diaNum"/>
		<!-- ��ȡ���к���,���û�����ʱ�ĺ��� -->
		<object name="queryCallInfo" classid="method://huawei/Other/QueryCallInfo">
			<param name="DialedNumber" expr="diaNum"/>
			<filled>
				<if cond="queryCallInfo=='SUCCESS'">
					<log>�û����ź���:<value expr="diaNum"/></log>
				</if>
			</filled>
		</object>
		
    </form>
</vxml>
