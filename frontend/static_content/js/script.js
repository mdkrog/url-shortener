$('#shorten-button').click(function(event) {
  event.preventDefault();

  var base_url = "http://localhost:3000"
  var input_text = ""
  input_text = $("#input_field").val();

  if(input_text.length > 0){
    $.ajax({
      url: base_url,
      type: 'post',
      data: {
        url: input_text
      },
      dataType: 'json',
      success: function (data) {
        console.info(data);
        $("#output a").attr("href", base_url + data.short_url);
        $("#output a").text(base_url + data.short_url);
      }
    });
  }
});