$( document ).ready(function() {

  $('#country').change( function(evt){
    evt.preventDefault()
    if( $( this ).val() != "" ){
      var country_id = $( this ).val();
      get_country_states(country_id);
      $('#states').remove();
    }
  });

  function get_country_states(country_id){
    $.ajax({
      type: "GET",
      url: "get_country_states/"+country_id,
      success: function (data){
        generate_select(data,'states');

        $('#states').change( function(evt){
          evt.preventDefault()
          if( $( this ).val() != ""){
            var state_id = $( this ).val();
            get_state_cities(state_id);
            $('#cities').remove();
          }
        });

      }
    });
  };
    
  function get_state_cities(state_id){
    $.ajax({
      type: "GET",
      url: "get_states_cities/"+state_id,
      success: function (data){
        generate_select(data,'cities');
      }
    }); 
  };

  function generate_select(data,option){
    var element = '<select id="'+option+'" class="form-control">';
    element += '<option selected></option>'
    for( var i=0; i < data.length; i++ ) {
        element += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
    }
    element += '</select>';
    $('.'+option+'_div').append(element);
    $('.'+option+'_div').show('slow');
  };


});