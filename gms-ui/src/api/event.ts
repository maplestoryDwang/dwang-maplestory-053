import axios from 'axios';
import type { HttpResponse } from '@/api/interceptor';

export interface EventSearch {
  pageNo?: number;
  pageSize?: number;
  onlyTotal?: boolean;
  notPage?: boolean;
  id?: number;
  eventName?: string;
  enabled?: boolean;
}

export interface EventDetailVO {
  id?: number;
  eventName: string;
  enabled: boolean;
  remark: string;
}

export function getEventList(data: EventSearch) {
  return axios.post('/event/v1/getEventList', data);
}

export function saveEvent(data: EventDetailVO) {
  return axios.post<HttpResponse<any>>('/event/v1/saveEvent', data);
}

export function deleteEvent(data: EventDetailVO) {
  return axios.post<HttpResponse<any>>('/event/v1/deleteEvent', data);
}
