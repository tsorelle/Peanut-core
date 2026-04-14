# Typescript updates

- web.root/packages/knockout_view/pnut/core/App.ts
  ShowBannerMessage(), HidewaitMessage()
  - Tested in dev: core and fma - 2024-12-21
- web.root/packages/knockout_view/pnut/core/PeanutLoader.ts<br>
  getConfig(), loadHtml()
  - Tested in dev: core and fma - 2024-12-21
- web.root/nutshell/pnut/js/ViewModelHelpers.ts<br>
  Added: Helper.checkNumeric() to replace jQuery.inNumeric() affects.
  additional corrections and additions:
  validateCurrency(), isValidDate, endsWith
- web.root/nutshell/pnut/extensions/BootstrapFive/classes/BootstrapFiveUiHelper.ts<br>
  improved syntax to accept string or object for modls
- web.root/nutshell/pnut/core/ViewModelBase.ts<br>
  added showModal() and hideModal() delebates to ui.helper
- web.root/nutshell/pnut/components/modalConfirmComponent.ts<br>
  changed bootstrap version default to 5
- web.root/nutshell/pnut/packages/mailboxes/components/mailboxManagerComponent.ts<br>
  updated error messages
- web.root/nutshell/pnut/extensions/BootstrapFive/classes/BootstrapFiveUiHelper.ts<br>
  added framework neutral syntax for showModal and hideModal
- jquery fixes:
  - web.root/nutshell/pnut/core/WaitMessage.ts
  - web.root/nutshell/pnut/extensions/BootstrapFive/classes/BootstrapFiveUiHelper.ts
  - ViewModelBase
- Modal fixes:
  - web.root/nutshell/pnut/components/cleanHtmlComponent.ts
  - web.root/nutshell/pnut/components/lookupEditComponent.ts
  - WaitMessage
  - PermissionsViewModel
  - SchedulerViewModel


  
  
