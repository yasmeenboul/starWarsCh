({
    makeCallout : function(component, swId) {
        console.log('hello from helper swId='+swId);
        // 1.call server controller callout method
        // 3.when the server is available to execute this action
        
        let action = component.get("c.setSwId");
        action.setParams({
            "swId":swId
        });
        // 4.when the version contol comes back from server side with response
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                  
                console.log('string response: '+JSON.stringify(response.getReturnValue()));
                let swRes = JSON.parse(JSON.stringify(response.getReturnValue()));
                component.set("v.swRes",swRes);
                console.log('json.parse effect: '+JSON.parse(JSON.stringify(response.getReturnValue())));
                if(component.get("v.swRes")==null){
                    alert('There is no recorord for this number');
                }else
                    console.log('swRes api response object'+component.get("v.swRes")); 
                this.saveRecordhelper(component, component.get("v.swRes") );
            }
            else{
                console.log('Page not found or something went wrong with server methods expectations');
            }
        });
        //2.Enqueue the ascynchronous action to be executed next when the server is available
        $A.enqueueAction(action);
        
    },
    saveRecordhelper : function(component, swRes){
        
        console.log('hello from helper/saveRecordhelper swRes='+swRes);
        // 1.call server controller callout method
        // 3.when the server is available to execute this action  
        let action2 = component.get("c.saveRecord");
        action2.setParams({
            "swRes":swRes
        });
        // 4.when the version contol comes back from server side with response
        action2.setCallback(this, function(response){
            console.log('response.getReturnValue()'+response.getReturnValue());
            let state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.swChar", response.getReturnValue());
                if(component.get("v.swChar")==null){
                    alert('Number with this record is already exist, please enter another number');
                }else
                    alert("One record is added successfully to your org");
                    console.log('swChar api sobject'+component.get("v.swChar"));
            }
            else{
                console.log('something went wrong with server methods calling');
            }
        });
        //2.Enqueue the ascynchronous action to be executed next when the server is available
        $A.enqueueAction(action2);
        
    }
})