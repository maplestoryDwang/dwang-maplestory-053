import axios from 'axios';
import type { HttpResponse } from '@/api/interceptor';

export interface getEventFilter {
  pageNo?: number;
  pageSize?: number;
  onlyTotal: boolean;
  notPage: boolean;
  eventId?: number;
  eventName?: string;
}

export interface EventDetailVO {
    id: number;
    eventName: string;
    enabled: boolean;
    remark: string;
}


export function getEventList(data: getEventFilter) {
  return axios.post('/event/v1/getEventList', data);
}


export function saveEvent(data: EventDetailVO) {
  return axios.post<HttpResponse<any>>('/event/v1/saveEvent', data);
}

// 7. 删除配方
export function deleteEvent(data: EventDetailVO) {
  return axios.post<HttpResponse<any>>('/event/v1/deleteEvent', data);
}

