// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// my_market
var my_market_table = $('#my_market_table').DataTable({
    "columnDefs": [
        { "targets": [0,2,3,4,5], "searchable": false },
        { "targets": [5], "orderable": false }
    ],
    "language": {
        "search": "Search By Category:"
    }
});


// $('#my_market').dataTable( {
//     "columnDefs": [
//       { "searchable": false, "targets": 0 }
//     ]
// } );


// $(document).ready(function () {
//     // Setup - add a text input to each footer cell
//     $('#my_market thead tr')
//         .clone(true)
//         .addClass('filters')
//         .appendTo('#my_market thead');
 
//     var table = $('#my_market').DataTable({
//         orderCellsTop: true,
//         fixedHeader: true,
//         initComplete: function () {
//             var api = this.api();
 
//             // For each column
//             api
//                 .columns()
//                 .eq(0)
//                 .each(function (colIdx) {
//                     // Set the header cell to contain the input element
//                     var cell = $('.filters th').eq(
//                         $(api.column(colIdx).header()).index()
//                     );
//                     var title = $(cell).text();
//                     $(cell).html('<input type="text" placeholder="' + title + '" />');
 
//                     // On every keypress in this input
//                     $(
//                         'input',
//                         $('.filters th').eq($(api.column(colIdx).header()).index())
//                     )
//                         .off('keyup change')
//                         .on('change', function (e) {
//                             // Get the search value
//                             $(this).attr('title', $(this).val());
//                             var regexr = '({search})'; //$(this).parents('th').find('select').val();
 
//                             var cursorPosition = this.selectionStart;
//                             // Search the column for that value
//                             api
//                                 .column(colIdx)
//                                 .search(
//                                     this.value != ''
//                                         ? regexr.replace('{search}', '(((' + this.value + ')))')
//                                         : '',
//                                     this.value != '',
//                                     this.value == ''
//                                 )
//                                 .draw();
//                         })
//                         .on('keyup', function (e) {
//                             e.stopPropagation();
 
//                             $(this).trigger('change');
//                             $(this)
//                                 .focus()[0]
//                                 .setSelectionRange(cursorPosition, cursorPosition);
//                         });
//                 });
//         },
//     });
// });