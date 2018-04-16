/*
 * Copyright (C) 2018 Dimitris Kardarakos
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3 of
 * the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include "GlosbitConfig.h"

#include <KConfig>
#include <KConfigGroup>

class GlosbitConfig::Private
{
public:
    Private()
        : config("glosbitrc")
    {};
    KConfig config;
};

GlosbitConfig::GlosbitConfig(QObject* parent)
    : QObject(parent)
    , d(new Private)
{
    QString recentSource = d->config.group("general").readEntry("recent_source", QString());
    QString recentTarget = d->config.group("general").readEntry("recent_target", QString());
    if(recentSource.isEmpty() && recentTarget.isEmpty()) {
        d->config.sync();
    }
}

GlosbitConfig::~GlosbitConfig()
{
    delete d;
}

QString GlosbitConfig::recentSource() const
{
    QString recentSource = d->config.group("general").readEntry("recent_source", QString());
    return recentSource;
}
QString GlosbitConfig::recentTarget() const
{
    QString recentTarget = d->config.group("general").readEntry("recent_target", QString());
    return recentTarget;
}


void GlosbitConfig::setRecentSource(const QString & dictionaryIndex)
{
        d->config.group("general").writeEntry("recent_source", dictionaryIndex);
        d->config.sync();
        emit recentSourceChanged();
}


void GlosbitConfig::setRecentTarget(const QString & dictionaryIndex)
{
        d->config.group("general").writeEntry("recent_target", dictionaryIndex);
        d->config.sync();
        emit recentTargetChanged();
}
