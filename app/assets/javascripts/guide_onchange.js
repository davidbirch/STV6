function guide_onchange_handler(){
    
        var region_select_field = document.getElementById("region");
        var region_name = region_select_field.options[region_select_field.selectedIndex].value;
        var sport_select_field = document.getElementById("sport");
        var sport_name = sport_select_field.options[sport_select_field.selectedIndex].value;
        
        //Forward browser to new url
        var new_url = ('/' + region_name)
        if (sport_name != "") {
                new_url = new_url + '/' + sport_name
        }
        window.location = new_url ;
}