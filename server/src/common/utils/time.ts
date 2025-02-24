import dayjs from 'dayjs';
import duration from 'dayjs/plugin/duration';
import isToday from 'dayjs/plugin/isToday';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

// In general, you can do without all of this; it depends on your project. I left it as an example.

// dayjs.extend(utc);
// dayjs.extend(timezone);
// dayjs.extend(isToday);
// dayjs.extend(duration);

export const time = dayjs;
