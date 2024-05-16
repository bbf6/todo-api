// you need to install the action cable library from npm:
//
//   npm install @rails/actioncable

import { createConsumer } from '@rails/actioncable'

const consumer = createConsumer('wss://todo.devartiral.com/api/cable')

export default consumer
