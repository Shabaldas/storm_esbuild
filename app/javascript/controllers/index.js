// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import { Alert, Autosave, Dropdown, Modal, Tabs, Popover, Slideover } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('tabs', Tabs)
application.register('popover', Popover)
application.register('slideover', Slideover)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SelectController from "./select_controller"
application.register("select", SelectController)

import CheckboxFamilyController from "./checkbox_family_controller"
application.register("checkbox-family", CheckboxFamilyController)

import ToggleController from "./toggle_controller"
application.register("toggle", ToggleController)

