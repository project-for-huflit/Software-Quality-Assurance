import type { UserConfig } from '@commitlint/types';
import { RuleConfigSeverity } from '@commitlint/types';

// const _0 = RuleConfigSeverity.Disabled;
const _1 = RuleConfigSeverity.Warning;
const _2 = RuleConfigSeverity.Error;

const Configuration: UserConfig = {
	extends: ['@commitlint/config-conventional'],
	parserPreset: 'conventional-changelog-atom',
	formatter: '@commitlint/format',
	rules: {
		'type-enum': [
			_1,
			'always',
			[
				'#', // id issue
				'Foo', // Demo
				'Feat', // new feature
				'Config', // new config
				'Fix', // fix bug
				'Improve', // improve code
				'perf', // optimize code that dont's change current feat's app 
				'Refactor', // refactor code, dont fix bug or add new feat
				'Docs', // Add document
				'Chore', // Thay đổi nhỏ trong quá trình phát triển
				'Style', // Sửa lỗi kiểu chữ, định dạng, không ảnh hưởng đến logic
				'Test', // Write unit test
				'Revert', // Revert one or many commit before that
				'Ci', // Setting or Change config CI/CD
				'Build', // Thay đổi liên quan đến hệ thống build hoặc công cụ.
			],
		],
		'type-case': [_2, 'always', 'lower-case'],
		'type-empty': [_2, 'never'],
		// 'scope-empty': [2, 'never'],
		// 'subject-empty': [2, 'never'],
		'subject-full-stop': [_2, 'never', '.'],
		'header-max-length': [_1, 'always', 80],
	},
};

export default Configuration;
