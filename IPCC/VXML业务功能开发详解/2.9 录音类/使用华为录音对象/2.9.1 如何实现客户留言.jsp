<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
		<!-- VP ¼��-->
		<object name="vprecord" classid="method://huawei/InOutPut/VPRecord">
			<!-- ¼���ļ����ļ��� ���·������Ϊ80 ���ַ� -->
			<param name="FileName" value="y:\zzyrecord\tmp.wav"/>
			<!-- ���¼��ʱ�� Ĭ��Ϊ30 �� -->
			<param name="MaxTime" value="20"/>
			<param name="RecordMode" value="0"/>
			<param name="RecordType" value="1"/>
			<!-- �Ƿ�����ͨ����������¼�� 
				����Ϊ1����ʾ����������¼�����Ҳ�������ʽ��ʽ��������¼���ɹ��󣬱���
						�ȴ����û���������Ž���¼������ʱ�ŴӴ�object �����з��ء�
				����Ϊ2����ʾ���÷�������ʽ����IVR�·�¼��������ȴ����Ŷӻ���Ӧ��ACK
						��Ϣ���ʹӴ�object �����з��أ������ٵȴ��պš�
				����Ϊ����ֵ����ʾ������������¼�����Ҳ���������ʽ��������¼���ɹ�
						�󣬱���ȴ����û��һ������߳������õ�¼���ʱ�䣬�Ż�Ӵ�object �����з��ء�
				���Է�������ֵ��ֻ��0��Ч��
			-->
			<param name="DtmfEnd" 	value="0"/>
			<!-- ¼��ģʽ Ĭ��Ϊ0
				 0 ��ʾ����
				 1 ��ʾ׷�ӷ�ʽ
			 -->
			<param name="RecordMode" value="0"/>
			<!-- ¼������ -->
			<param name="RecordType" value="65"/>
			<filled>
				<if cond="vprecord=='USER_HOOK'">
					<log>�û��һ�</log>
					<exit/>
				<elseif  cond="vprecord=='RECORD_END'"/>
					<log>¼������</log>
					<exit/>
				<elseif  cond="vprecord=='RECORD_ERROR'"/>
					<log>¼��ʧ��</log>
					<exit/>
				<elseif  cond="vprecord=='TIME_OUT'"/>
					<log>��ʱ</log>
				<elseif  cond="vprecord=='ERROR'"/>	
					<log>����</log>			
					<exit/>						
				</if>
			</filled>
		</object>
    </form>
</vxml>
