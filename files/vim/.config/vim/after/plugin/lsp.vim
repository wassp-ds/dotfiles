" LSP configuration
let g:lsp_auto_enable = 1

" Explicitly disable autocompletion features
let g:lsp_completion_enabled = 0
let g:lsp_signature_help_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_fold_enabled = 0
let g:lsp_hover_conceal = 0
let g:lsp_preview_autoclose = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_inlay_hints_enabled = 0


" Configure how signs appear in the gutter
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_echo_float_cursor = 0
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_code_action_signs_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': 'E'}
let g:lsp_diagnostics_signs_warning = {'text': 'W'}
let g:lsp_diagnostics_signs_information = {'text': 'I'}
let g:lsp_diagnostics_signs_hint= {'text': 'H'}


if executable('pyls')
        " Python Language Server
        au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'allowlist': ['python'],
                \ })
endif

" LSP key mappings
function! s:on_lsp_buffer_enabled() abort
        setlocal signcolumn=yes
        setlocal omnifunc=lsp#complete

        " Navigation and information hotkeys
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> <leader>n <plug>(lsp-rename)
        nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        nmap <buffer> K <plug>(lsp-hover)

        " Convenient command to show diagnostics in location list
        nmap <buffer> <leader>e :LspDocumentDiagnostics<CR>
endfunction

augroup lsp_install
        au!
        " Call the function on LSP buffer enabled
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
