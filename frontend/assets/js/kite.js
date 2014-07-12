$(document).ready(function() {

  $("#e6").select2({
      placeholder: "What would you like to do?",
      minimumInputLength: 1,
      ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
          // url: "http://127.0.0.1:5000/?phrase=" + term,
          url: "http://localhost:5000/suggest_actions",
          dataType: 'json',
          data: function (term, page) {
              return {
                  phrase: term, // search term
                  // page_limit: 10,
                  // apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
              };
          },
          results: function (data, page) { // parse the results into the format expected by Select2.
              // since we are using custom formatting functions we do not need to alter remote JSON data
              // return {results: data.suggestions};
              return {results: data};
          }
      },
      // initSelection: function(element, callback) {
          // // the input tag has a value attribute preloaded that points to a preselected movie's id
          // // this function resolves that id attribute to an object that select2 can render
          // // using its formatResult renderer - that way the movie name is shown preselected
          // var id=$(element).val();
          // if (id!=="") {
              // $.ajax("http://api.rottentomatoes.com/api/public/v1.0/movies/"+id+".json", {
                  // data: {
                      // apikey: "ju6z9mjyajq2djue3gbvv26t"
                  // },
                  // dataType: "json"
              // }).done(function(data) { callback(data); });
          // }
      // },
      formatResult: suggestionFormatResult, // omitted for brevity, see the source of this page
      formatSelection: suggestionFormatSelection,  // omitted for brevity, see the source of this page
      dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
      escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
  });
});

function suggestionFormatResult(suggestion) {
    var markup = "<table class='movie-result'><tr>";
    markup += suggestion
    // if (movie.posters !== undefined && movie.posters.thumbnail !== undefined) {
        // markup += "<td class='movie-image'><img src='" + movie.posters.thumbnail + "'/></td>";
    // }
    // markup += "<td class='movie-info'><div class='movie-title'>" + movie.title + "</div>";
    // if (movie.critics_consensus !== undefined) {
        // markup += "<div class='movie-synopsis'>" + movie.critics_consensus + "</div>";
    // }
    // else if (movie.synopsis !== undefined) {
        // markup += "<div class='movie-synopsis'>" + movie.synopsis + "</div>";
    // }
    markup += "</td></tr></table>";
    return markup;
}

function suggestionFormatSelection(suggestion) {
    return suggestion;
}

