// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('.achievementToolTipLink').each(function(){
    $currentLink = $(this);
    $currentLink.qtip({
       content: {
          text: '<img src="/images/ajax-tooltip-loader.gif" alt="Loading..." />', // Loading text...
          ajax: {
             url: $currentLink.attr('href'), // URL to the JSON script
             type: 'GET', // POST or GET
             data: { }, // Data to pass along with your request
             dataType: 'json', // Tell it we're retrieving JSON
             success: function(data, status) {
                /* Process the retrieved JSON object
                 *    Retrieve a specific attribute from our parsed
                 *    JSON string and set the tooltip content.
                 */
                var content = '<img src="' + data.image +'" alt="' + data.name + '"/>' +"<br />";
                content += 'Name: ' + data.name + "<br />";
                content += 'Requirements: ' + data.requirements + "<br />";
                content += 'Description: ' + data.description + "<br />";
                this.set('content.text', content);

                // Disable the default behaviour
                return false;
             }
          }
       }
   })
});

