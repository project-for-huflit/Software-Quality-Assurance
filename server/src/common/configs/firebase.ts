import * as firebaseAdmin from 'firebase-admin';
import * as fs from 'fs';

export function setupFirebase(firebaseKeyFilePath: string) {
	const firebaseServiceAccount = JSON.parse(
		fs.readFileSync(firebaseKeyFilePath).toString(),
	);

	const adminConfig: firebaseAdmin.ServiceAccount = {
		projectId: firebaseServiceAccount.project_id,
		privateKey: firebaseServiceAccount.private_key,
		clientEmail: firebaseServiceAccount.client_email,
	};

	if (firebaseAdmin.app.length === 0) {
		console.log('Init firebase app!');
		firebaseAdmin.initializeApp({
			credential: firebaseAdmin.credential.cert(firebaseServiceAccount),
			databaseURL: `https://${adminConfig.projectId}.firebaseio.com`,
		});
	}
}
