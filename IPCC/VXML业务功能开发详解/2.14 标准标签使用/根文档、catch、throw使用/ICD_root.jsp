<?xml version="1.0" encoding="GB2312"?>
<vxml version="2.0">
	<property name="inputmodes" value="dtmf"/>
	<!-- Number -->
	<var name="failCount" expr="3"/>
	<!--config paras-->
	<var name="AudioPath" expr="'y:\\voice\\'"/>

	<!-- ȡ�ű��ļ�ʧ�� -->
	<catch event="error.badfetch">
		<log label="root">
			root:error.badfetch
		</log>
		<goto next="#exitCall"/>
	</catch>
	<!-- �﷨�ļ����� -->
	<catch event="error.grammar.addfailed">
		<log label="root">
			error.grammar.addfailed
		</log>
		<goto next="#exitCall"/>
	</catch>
	<catch event="diconnectCalling">
		<!-- �ͷ�������Դ��������connection.disconnect.hangup�¼� -->
		<log label="root">
			event:diconnectCalling
		</log>
		
		<goto next="#exitCall"/>
	</catch>
	<catch event="logAuto">
		<!-- ���¼����С�������Դ�Ѿ��ͷ� -->
		<log label="root">
			event:logAuto
		</log>
		<goto next="#exitCall"/>
	</catch>
	<catch event="connection.disconnect.hangup">
		<log label="root">
			event:connection.disconnect.hangup
		</log>
		<goto next="#exitCall"/>
	</catch>
	<script>

 <![CDATA[		
     function isDigit(s) {
		var r,re;
		re = /\d*/i; //\d��ʾ����,*��ʾƥ��������
		r = s.match(re);
		return (r==s)?true:false;
	}
	function getFullAudio(vf)
	 {
	 	if (vf == '')
	 		return "";
	  return AudioPath + vf;
	 }
	function getCurrentTime(myTime) {
		 var dataObject;
		 if(myTime==null) dataObject = new Date();
		 else dataObject=myTime;
		 var Result;
		 var Temp;
		 Result="";
         Temp=dataObject.getFullYear();
			if( Temp<10 ) {Result+="0";	}
			Result+=Temp;
		 Temp=dataObject.getMonth()+1;
			if( Temp<10 ) {Result+="0";	}
			Result+=Temp;
		  Temp=dataObject.getDate();
			if( Temp<10 ) {Result+="0";	}
			Result+=Temp;
	      Temp=dataObject.getHours();
		  if( Temp<10 ) {Result+="0"; }
		  Result+=Temp;
		  Temp=dataObject.getMinutes();
		  if( Temp<10 ) {Result+="0"; }
		  Result+=Temp;
		  Temp=dataObject.getSeconds();
		  if( Temp<10 ) {Result+="0"; }
		  Result+=Temp;
		  return Result;
	      }
	      
	     

]]> 		</script>
	<form id="disconnectCall">
		<block name="disconnect">
			<disconnect/>
			<exit/>
		</block>
	</form>
	<form id="exitCall">
		<block name="exit">
			<exit/>
		</block>
	</form>
</vxml>
