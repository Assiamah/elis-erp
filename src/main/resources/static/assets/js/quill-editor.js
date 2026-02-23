(function () {
    'use strict';
    /* quill snow editor */
    const toolbarOptions = [
        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
        [{ 'font': [] }],
        ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
        ['blockquote', 'code-block'],

        [{ 'header': 1 }, { 'header': 2 }],               // custom button values
        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
        [{ 'script': 'sub' }, { 'script': 'super' }],      // superscript/subscript
        [{ 'indent': '-1' }, { 'indent': '+1' }],          // outdent/indent
        [{ 'direction': 'rtl' }],                         // text direction

        [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown

        [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
        [{ 'align': [] }],

        ['image', 'video'],
        ['clean']                                         // remove formatting button
    ];

    const quill = new Quill('#lc_search_report_summary_details', {
        modules: {
            toolbar: toolbarOptions
        },
        theme: 'snow'
    });

    // const quill2 = new Quill('#lc_search_report_summary_details_2', {
    //     modules: {
    //         toolbar: toolbarOptions
    //     },
    //     theme: 'snow'
    // });

    // const quill3 = new Quill('#lc_search_report_summary_details_3', {
    //     modules: {
    //         toolbar: toolbarOptions
    //     },
    //     theme: 'snow'
    // });

    const quill4 = new Quill('#lc_concurrence_certificate_summary_details', {
        modules: {
            toolbar: toolbarOptions
        },
        theme: 'snow'
    });

})();