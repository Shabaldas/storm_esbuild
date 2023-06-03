// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import { Alert, Autosave, Dropdown, Tabs, Popover, Slideover } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('dropdown', Dropdown)
application.register('tabs', Tabs)
application.register('popover', Popover)
application.register('slideover', Slideover)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import SelectController from "./select_controller"
application.register("select", SelectController)

import CheckboxFamilyController from "./checkbox_family_controller"
application.register("checkbox-family", CheckboxFamilyController)

import DropzoneController from "./dropzone_controller"
application.register("dropzone", DropzoneController)

import ModalsController from "./modals_controller"
application.register("modals", ModalsController)

import TogglerController from "./toggler_controller"
application.register("toggler", TogglerController)

import NestedFormController from "./nested_form_controller"
application.register("nested-form", NestedFormController)
