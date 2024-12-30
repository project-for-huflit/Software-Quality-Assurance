import * as fs from 'fs';
import * as firebaseAdmin from 'firebase-admin';

export function setupFirebase(firebaseKeyFilePath: string) {
	const firebaseServiceAccount = JSON.parse(
		fs.readFileSync(firebaseKeyFilePath).toString(),
	);

	if (firebaseAdmin.app.length === 0) {
		console.log('Init firebase app!');
		firebaseAdmin.initializeApp({
			credential: firebaseAdmin.credential.cert(firebaseServiceAccount),
		});
	}
}
