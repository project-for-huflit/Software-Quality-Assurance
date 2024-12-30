import { Inject, Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';

@Injectable()
export class FirestoreService {
	private firestore: admin.firestore.Firestore;

	constructor(@Inject('FIREBASE_APP') private firebaseApp: admin.app.App) {
		this.firestore = this.firebaseApp.firestore();
	}

	async getCollection(collection: string) {
		const snapshot = await this.firestore.collection(collection).get();
		return snapshot.docs.map((doc) => doc.data());
	}
}
