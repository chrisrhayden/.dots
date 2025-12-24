#include "search.hpp"

#include <cfloat>
#include <qvariant.h>

#include "fzy.hpp"

typedef std::tuple<std::size_t, float> idx_score;

bool score_sort(idx_score a, idx_score b) {
    return std::get<1>(a) > std::get<1>(b);
}

QObjectList Search::search_entries(QString query) {
    if (query.isEmpty()) {
        return this->m_entries;
    }

    std::string needle = query.toStdString();

    std::vector<std::tuple<std::size_t, float>> scores;

    for (std::size_t idx = 0; idx < this->m_entries.length(); ++idx) {
        if (this->m_entries[idx]->property("name").isNull()) {
            continue;
        }

        std::string name =
            this->m_entries[idx]->property("name").toString().toStdString();

        float score = match(needle, name);

        scores.push_back(std::make_tuple(idx, score));
    }

    std::sort(scores.begin(), scores.end(), score_sort);

    QObjectList filtered;

    for (std::size_t idx = 0; idx < scores.size(); ++idx) {
        if (std::get<1>(scores[idx]) == FLT_MIN) {
            continue;
        }

        std::size_t e_idx = std::get<0>(scores[idx]);

        filtered.append(this->m_entries[e_idx]);
    }

    return filtered;
}

void Search::setEntries(QObjectList& entries) {
    this->m_entries = entries;

    emit entriesChanged();
}
