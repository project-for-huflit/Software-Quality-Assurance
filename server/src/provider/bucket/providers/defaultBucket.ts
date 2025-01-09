export const getDefaultOptions = (role: string) => ({
	entity: 'allUsers',
	role: role,
});

export class DefaultBucketProvider {
	static bucketName = 'default';
}
