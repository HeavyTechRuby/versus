import { Application } from "@hotwired/stimulus"
import PasswordVisibility from '@stimulus-components/password-visibility'
import Notification from '@stimulus-components/notification'

const application = Application.start()
application.register('password-visibility', PasswordVisibility)
application.register('notification', Notification)

application.debug = false
window.Stimulus   = application

export { application }
