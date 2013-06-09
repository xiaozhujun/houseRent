(function($){
	$.URL = {
		"user":{
			"resetPwd":"/User/resetPwd",
			"update":"/User/update",
			"info":"/User/info",
			"invite":"/InvitationCode/inviteFriend",
			"login":"/User/doLogin",
			"register":"/User/add",
			"verify":"/User/verify",
			"findFriend":"/User/findFriend",
		},
		"friend":{
			"applyFriend":"/Friend/applyFriend",
			"applyingUntreated":"/Friend/applyingUntreated",
			"applyingPassed":"/Friend/applyingPassed",
			"applyingRefused":"/Friend/applyingRefused",
			"applyingUntreat":"/Friend/applyingUntreat",
			"applyingPass":"/Friend/applyingPass",
			"applyingRefuse":"/Friend/applyingRefuse",
			"refuseApply":"/Friend/refuseApply",
			"passApply":"/Friend/passApply",
			"myFriend":"/Friend/myFriend",
			"invitedFriend":"/Friend/invitedFriend",
		},
		"house":{
			"houselist":"/House/houseList",
			"publishhouse":"/House/publishHouseAction",
			
		}
			
	}
})(jQuery);