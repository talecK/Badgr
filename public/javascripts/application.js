// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('.achievementToolTipLink').qtip({
   content: {
      text: 'Loading...', // The text to use whilst the AJAX request is loading
      ajax: {
         url: '/path/to/file', // URL to the local file
         type: 'GET', // POST or GET
         data: {}, // Data to pass along with your request
         success: function(data, status) {
            return false; // Stop it from setting the content
         }
      }
   }
});

