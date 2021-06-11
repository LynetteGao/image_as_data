'''
This script is modified from the project randomly collecting the metadata of Climate Change YouTube videos.
and used to collect COVID-19 conspiracy Youtube videos.

For every search term, it searches from 2020-03-01 to 2020-05-31.

Every time it queries, it collects 10 videos by view count. The script also manages to delete repetitive videos and the video is already in the result of previous search term.

Output: searchterm_enddate.csv
Coder: Lynette Gao and Thanks to Lingzheng He
Date: May 2020 - Present
'''

from youtube_api import YouTubeDataAPI
import csv
import datetime
import pickle
import time

# topic information
TOPIC = 'Coronavirus'
SEARCH_TERMS = ['coronavirus']
            # ['Judy Mikovits','Bill Gates coronavirus','QAnon coronavirus','Coronavirus Vaccination',
            #                'Wuhan lab', 'bioweapon coronavirus','5G coronavirus','coronavirus flu'
            #                 ,'dean koontz darkness']  ##adding eveloped search terms here
VIDEOS_PER_QUERY = 10

# Check youtube api
API_KEY = 'your api key'


yt_api = YouTubeDataAPI(API_KEY)
yt_api.verify_key()

Metadata = lambda vid_list: yt_api.get_video_metadata(vid_list)

''' collect videos' metadata
'''


def get_metadata(vid_list, VID_SEEN):
    if not vid_list: return [], [0]
    try:
        metadata_list = Metadata(vid_list)
    except Exception as exc:
        print('>>> cannot retrieve the metadata_list for [{}...] as {}'.format(vid_list[0], exc))
        return [], [0]
    VID_SEEN = set(list(VID_SEEN))
    return metadata_list, [len(vid_list)]


METADATA, VID_SEEN = [], set()
end = 27  # You can Change the end searching day here
# start = 6

# iterate search terms to collect videos and metadata
for term in SEARCH_TERMS:
    DATES = []
    DATES_MARCH = [datetime.datetime(2020, 3, day, 0, 0) for day in range(1, 32)]
    DATES_APRIL = [datetime.datetime(2020, 4, day, 0, 0) for day in range(1, 31)]
    DATES_MAY = [datetime.datetime(2020, 5, day, 0, 0) for day in range(1, 32)]
    DATES += DATES_MARCH
    DATES += DATES_APRIL
    DATES += DATES_MAY
    #DATES.append((datetime.datetime(2020, 5, end-1, 23, 59, 59)))
    # DATES.append((datetime.datetime(2020, 5, end, 23, 59, 59)))

    print('searching current term: [{}]'.format(term))
    for i in range(len(DATES) - 1):
        print('searching from {} to {}'.format(DATES[i], DATES[i + 1]))
        try:
            search_result = yt_api.search(
                term,
                max_results=VIDEOS_PER_QUERY,
                order_by='viewCount',
                relevance_language='en',
                published_after=DATES[i],
                published_before=DATES[i + 1],
                type='video',
            )
        except Exception as exc:
            print('>>> cannot do searching for {} as {}'.format(term, exc))
            search_result = []
        vid_list = [item['video_id'] for item in search_result if
                    item['video_id'] not in VID_SEEN]  # delete repetitive videos
        VID_SEEN = set(list(VID_SEEN) + vid_list)
        print('  vid_list with length [{}] spawn'.format(len(vid_list)))
        _metadata, _sampling_path = get_metadata(vid_list, VID_SEEN)
        # add additional attributes
        for info in _metadata:
            info.update({'science topic': TOPIC})
            info.update({'search term': term})
            id = info.get('video_id') #'id:' + info.get('video_id')
            info.update({'video_id': id})  # avoid garbbled characters in csv
        print('  total [{}] videos collected'.format(len(_metadata)))
        METADATA += _metadata
    print('finish searching term: [{}]'.format(term))

    # generate output
    print('write ' + term + ' metadata to csv...')
    column = ['video_id', 'channel_title', 'channel_id', 'video_publish_date',
              'video_title', 'video_description', 'video_category', 'video_view_count',
              'video_comment_count', 'video_like_count', 'video_dislike_count',
              'video_thumbnail', 'video_tags', 'collection_date', 'science topic', 'search term']

    # store the data as binary data stream
    # with open('../data/term+'.data', 'wb') as filehandle:
    #     pickle.dump(METADATA, filehandle)

    try:
        # with open('../output/term + '-May'+ str(end)+ '.csv', 'w', newline='', encoding='utf-8') as csvfile:
        with open('covid19.csv', 'w', newline='', encoding='utf-8') as csvfile:  # has to handle unicode
            writer = csv.DictWriter(csvfile, fieldnames=column)
            writer.writeheader()
            for data in METADATA:
                data['video_publish_date'] = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(data['video_publish_date']))
                writer.writerow(data)
    except IOError:
        print('error writing to csv')
    print('...finished')
