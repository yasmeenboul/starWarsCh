({
    clickCreate : function(component, event, helper) {
        let swId = component.get("v.swId");
        if(swId == undefined || null){
           alert("Please enter valid value");
        }else{
            helper.makeCallout(component,swId);
        }

    },
})