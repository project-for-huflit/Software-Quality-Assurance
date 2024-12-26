import { Global, Module } from '@nestjs/common';
import * as admin from 'firebase-admin';

const firebaseApp = admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: 'https://<your-database-name>.firebaseio.com',
});

@Global()
@Module({
  providers: [
    {
      provide: 'FIREBASE_APP',
      useValue: firebaseApp,
    },
  ],
  exports: ['FIREBASE_APP'],
})
export class FirebaseModule {}