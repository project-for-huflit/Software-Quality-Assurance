import dayjs from 'dayjs';
import * as duration from 'dayjs/plugin/duration';
import * as isToday from 'dayjs/plugin/isToday';
import * as timezone from 'dayjs/plugin/timezone';
import * as utc from 'dayjs/plugin/utc';

// In general, you can do without all of this; it depends on your project. I left it as an example.

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.extend(isToday);
dayjs.extend(duration);

export const time = dayjs;
