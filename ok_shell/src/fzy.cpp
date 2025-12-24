#include "fzy.hpp"

#include <execinfo.h>

#include <QString>
#include <cfloat>
#include <qcontainerfwd.h>
#include <vector>

#define MAX_MATCH_LEN 1024
const float SCORE_GAP_LEADING = -0.005;
const float SCORE_GAP_TRAILING = -0.005;
const float SCORE_GAP_INNER = -0.01;
const float SCORE_MATCH_CONSECUTIVE = 1.0;

struct MatchData {
    std::string needle;
    std::string haystack;
    std::vector<float> bonuses;
};

// score current char higher if the last char was a slash
const float MATCH_SCORE_SLASH = 0.9;
// score the start of a word higher then not
const float MATCH_SCORE_WORD = 0.8;
// score capital letters higher
const float MATCH_SCORE_CAPITAL = 0.7;
// score higher then nothing if the last char was a dot
const float MATCH_SCORE_DOT = 0.6;

float get_b_score(char c, char last) {
    if (last == '/') {
        return MATCH_SCORE_SLASH;
    } else if (c == '-') {
        return MATCH_SCORE_WORD;
    } else if (c == '_') {
        return MATCH_SCORE_WORD;
    } else if (c == ' ') {
        return MATCH_SCORE_WORD;
    } else if (c == '.') {
        return MATCH_SCORE_DOT;
    } else {
        if (c && last) {
            return MATCH_SCORE_CAPITAL;
        } else {
            return 0;
        }
    }
}

void make_bonuses(std::string* haystack, std::vector<float>* bonuses) {
    char last = '/';

    for (char const c : std::as_const(*haystack)) {

        float b = get_b_score(c, last);
        last = c;

        bonuses->push_back(b);
    }
}

void match_score(
    MatchData* data,
    std::size_t needle_pos,
    float* current_d,
    float* current_m,
    float const* last_d,
    float const* last_m
) {
    size_t needle_len = data->needle.size();
    size_t haystack_len = data->haystack.size();

    float prev_score = FLT_MIN;
    float gap_score =
        needle_pos == needle_len - 1 ? SCORE_GAP_TRAILING : SCORE_GAP_INNER;

    float prev_d = FLT_MIN;
    float prev_m = FLT_MIN;

    for (std::size_t h_idx = 0; h_idx < haystack_len; ++h_idx) {
        char n = data->needle.at(needle_pos);

        char h = data->haystack.at(h_idx);

        if (n == h) {

            float score = FLT_MIN;

            if (needle_pos == 0) {
                score =
                    (float)(h_idx * SCORE_GAP_LEADING) + data->bonuses[h_idx];
            } else if (h_idx > 0) {
                score = std::max(
                    prev_m + data->bonuses[h_idx],
                    prev_d + SCORE_MATCH_CONSECUTIVE
                );
            }

            prev_d = last_d[h_idx];
            prev_m = last_m[h_idx];

            prev_score = std::max(score, prev_score + gap_score);
            current_d[h_idx] = score;
            current_m[h_idx] = prev_score;
        } else {
            prev_score = prev_score + gap_score;
            prev_d = last_d[h_idx];
            prev_m = last_m[h_idx];

            current_d[h_idx] = FLT_MIN;
            current_m[h_idx] = prev_score;
        }
    }
}

float match(std::string needle, std::string haystack) {
    if (needle.empty() || haystack.empty()) {
        return false;
    }

    if (needle.size() > MAX_MATCH_LEN || haystack.size() > MAX_MATCH_LEN) {
        return FLT_MIN;
    }

    if (needle == haystack) {
        return FLT_MAX;
    }

    std::vector<float> bonuses;

    make_bonuses(&haystack, &bonuses);

    // is c++ for fucking real
    std::transform(
        haystack.begin(),
        haystack.end(),
        haystack.begin(),
        [](unsigned char c) { return std::tolower(c); }
    );

    MatchData data;
    data.needle = needle;
    data.haystack = haystack;
    data.bonuses = bonuses;

    assert(data.haystack.size() == data.bonuses.size());

    size_t needle_len = data.needle.size();
    assert(needle_len < MAX_MATCH_LEN);

    size_t haystack_len = data.haystack.size();
    assert(haystack_len < MAX_MATCH_LEN);

    float current_d[MAX_MATCH_LEN] = {0.0};
    float current_m[MAX_MATCH_LEN] = {0.0};

    for (std::size_t n_idx = 0; n_idx < needle_len; ++n_idx) {
        match_score(&data, n_idx, current_d, current_m, current_d, current_m);
    }

    return current_m[haystack_len - 1];
}
