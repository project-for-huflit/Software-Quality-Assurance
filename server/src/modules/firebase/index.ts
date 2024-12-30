import { Global, Module } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { FirestoreService } from './services/firestore.service';

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
		FirestoreService,
	],
	exports: ['FIREBASE_APP', FirestoreService],
})
export class FirebaseModule {}
